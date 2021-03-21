resource "kubernetes_pod" "unittest" {
  metadata {
    name      = "unittest-${var.test_number}"
    namespace = "frontend-test"

    labels = {
      app  = "frontend"
      role = "frontend-test"
    }
  }

  spec {
    volume {
      name = "data"
    }

    container {
      name    = "frontend"
      image   = "hsndocker/frontend:${var.frontend_version}"
      command = ["/bin/sh", "-c", "sleep infinity"]

      resources {
        limits = {
          cpu    = "1200m"
          memory = "512Mi"
        }

        requests = {
          memory = "512Mi"
          cpu    = "700m"
        }
      }
    }

    image_pull_secrets {
      name = kubernetes_secret.dockerhub_cred.metadata[0].name
    }
  }
}

resource "kubernetes_pod" "unittest" {
  metadata {
    name      = "unittest-${var.test_number}"
    namespace = "frontend-unittest"

    labels = {
      app  = "frontend"
      role = "frontend-unittest"
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
          cpu    = "1000m"
          memory = "256Mi"
        }

        requests = {
          memory = "128Mi"
          cpu    = "400m"
        }
      }
    }

    image_pull_secrets {
      name = kubernetes_secret.dockerhub_cred.metadata[0].name
    }
  }
}

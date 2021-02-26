resource "kubernetes_pod" "unittest" {
  metadata {
    name      = "unittest-${var.test_number}"
    namespace = "frontend-unittest"

    labels = {
      app  = "frontend"
      role = "unittest"
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
          cpu    = "2000m"
          memory = "512Mi"
        }

        requests = {
          memory = "256Mi"
          cpu    = "1000m"
        }
      }
    }
  }
}

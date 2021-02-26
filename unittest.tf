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
      # args    = ["start.sh"]

      # port {
      #   container_port = 3000
      # }

      resources {
        limits = {
          cpu    = "1000m"
          memory = "256Mi"
        }

        requests = {
          memory = "128Mi"
          cpu    = "500m"
        }
      }
    }
  }
}

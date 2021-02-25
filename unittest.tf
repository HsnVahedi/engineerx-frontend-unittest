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
      command = ["/bin/sh", "-c", "ls"]
      # args    = ["start.sh"]

      # port {
      #   container_port = 3000
      # }

      resources {
        limits = {
          cpu    = "500m"
          memory = "128Mi"
        }

        requests = {
          memory = "64Mi"
          cpu    = "100m"
        }
      }
    }
  }
}

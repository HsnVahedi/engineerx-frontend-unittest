resource "kubernetes_secret" "dockerhub_cred" {
  metadata {
    name = "dockerhub-cred"
    namespace = "frontend-unittest"
    labels = {
      role = "frontend-unittest"
    }
  }

  data = {
    ".dockerconfigjson" = <<DOCKER
{
  "auths": {
    "https://index.docker.io/v1/": {
      "auth": "${base64encode("${var.dockerhub_username}:${var.dockerhub_password}")}"
    }
  }
}
DOCKER
  }

  type = "kubernetes.io/dockerconfigjson"
}
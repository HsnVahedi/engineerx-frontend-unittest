resource "kubernetes_secret" "dockerhub_cred" {
  metadata {
    name = "dockerhub-cred-${var.test_number}"
    namespace = "frontend-test"
    labels = {
      role = "frontend-test"
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
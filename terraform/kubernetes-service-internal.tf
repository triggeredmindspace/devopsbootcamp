resource "kubernetes_service" "internal-service" {
  metadata {
    name      = "internal-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.internal-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8082
    }
  }
}



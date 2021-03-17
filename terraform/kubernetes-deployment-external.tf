resource "kubernetes_deployment" "external-deployment" {
  metadata {
    name = "external-deployment"
    labels = {
      App = "events-external"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 3
#    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-external"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-external"
        }
      }
      spec {
        container {
          image = "gcr.io/mar-roidtc310/external-image:v1.0.0"
          name  = "events-external"

          env   {
            name= "SERVER"
            value= "http://events-internal"
          }
      #    port {
      #      container_port = 80
      #    }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
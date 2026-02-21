terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"

  create_namespace = true

  values = [
    yamlencode({
      controller = {

        # Service exposure
        service = {
          type = "LoadBalancer"

          annotations = {
            "service.beta.kubernetes.io/aws-load-balancer-type"            = "nlb"
            "service.beta.kubernetes.io/aws-load-balancer-scheme"          = "internet-facing"
            "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "ip"
          }
        }

        # Replica scaling
        replicaCount = 2

        # Metrics for Prometheus
        metrics = {
          enabled = true
        }

        # Ingress class config
        ingressClassResource = {
          name = "nginx"
          enabled = true
          default = true
        }
      }
    })
  ]
}
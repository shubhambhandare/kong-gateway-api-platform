terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
  }
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_namespace" "platform" {
  metadata {
    name = "platform"
  }
}

resource "kubernetes_namespace" "kong" {
  metadata {
    name = "kong"
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "kubernetes_network_policy" "user_service_ingress" {
  metadata {
    name      = "user-service-allow-from-kong-and-ingress"
    namespace = kubernetes_namespace.platform.metadata[0].name
  }

  spec {
    pod_selector {
      match_labels = {
        app = "user-service"
      }
    }

    ingress {
      from {
        namespace_selector {
          match_labels = {
            name = kubernetes_namespace.kong.metadata[0].name
          }
        }
      }

      from {
        namespace_selector {
          match_labels = {
            name = kubernetes_namespace.ingress_nginx.metadata[0].name
          }
        }
      }
    }

    policy_types = ["Ingress"]
  }
}


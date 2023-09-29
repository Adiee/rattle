# provider "kubernetes" {
#   config_context_cluster = aws_eks_cluster.rattle_eks_cluster.name
# }


# resource "kubernetes_namespace" "rattle_namespace" {
#   metadata {
#     name = "rattle"
#   }
# }


# resource "kubernetes_deployment" "rattle_deployment" {
#   metadata {
#     name = "rattle-deployment"
#     namespace = kubernetes_namespace.rattle_namespace.metadata.0.name
#   }

#   spec {
#     replicas = 2

#     selector {
#       match_labels = {
#         app = "rattle-pod"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "rattle-pod"
#         }
#       }

#       spec {
#         container {
#           name  = "rattle-container"
#           image = "your-dockerhub-username/your-image-name:latest" 
#         }
#       }
#     }
#   }
# }


# resource "kubernetes_service" "rattle_service" {
#   metadata {
#     name      = "rattle-service"
#     namespace = kubernetes_namespace.rattle_namespace.metadata.0.name
#   }

#   spec {
#     selector = {
#       app = "rattle-pod"
#     }

#     port {
#       protocol   = "TCP"
#       port       = 80
#       target_port = 80
#     }

#     type = "LoadBalancer"
#   }
# }


# output "service_endpoint" {
#   value = kubernetes_service.rattle_service.status.0.load_balancer.0.ingress.0.ip
# }

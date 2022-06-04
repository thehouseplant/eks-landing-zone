data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.cluster.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.main.token
  load_config_file       = false
}

resource "kubernetes_cluster_role" "alb_ingress" {
  metadata {
    name = lower("${var.prefix}-ingress-controller")
    labels = {
      "app.kubernetes.io/name" = lower("${var.prefix}-ingress-controller")
    }
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["configmaps", "endpoints", "events", "ingresses", "ingresses/status", "services"]
    verbs      = ["create", "get", "list", "patch", "update", "watch"]
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["namespaces", "nodes", "pods", "secrets", "services"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "alb_ingress" {
  metadata {
    name = lower("${var.prefix}-ingress-controller")
    labels = {
      "app.kubernetes.io/name" = lower("${var.prefix}-ingress-controller")
    }
  }

  rule {
    api_group = "rbac.authorized.k8s.io"
    kind      = "ClusterRole"
    name      = lower("${var.prefix}-ingress-controller")
  }

  rule {
    kind      = "ServiceAccount"
    name      = lower("${var.prefix}-ingress-controller")
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "alb_ingress" {
  metadata {
    name      = lower("${var.prefix}-ingress-controller")
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name" = lower("${var.prefix}-ingress-controller")
    }
  }

  automount_service_account_token = true
}

resource "kubernetes_deployment" "alb_ingress" {
  metadata {
    name      = lower("${var.prefix}-ingress-controller")
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name" = lower("${var.prefix}-ingress-controller")
    }
  }

  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" = lower("${var.prefix}-ingress-controller")
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = lower("${var.prefix}-ingress-controller")
        }
      }
      spec {
        volume {
          name = kubernetes_service_account.alb_ingress.default_secret_name
          secret {
            secret_name = kubernetes_service_account.alb_ingress.default_secret_name
          }
        }
        container {
          image = "docker.io/amazon/aws-alb-ingress-controller:v1.1.4"
          name  = lower("${var.prefix}-ingress-controller")
          args = ["--ingress-class=alb",
            "--cluster-name=${aws_eks_cluster.cluster.name}",
            "--aws-vpc-id=${module.vpc.vpc_id}",
            "--aws-region=${var.region}"]
          volume_mount {
            name       = kubernetes_service_account.alb_ingress.default_secret_name
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            read_only  = true
          }
        }
        service_account_name = lower("${var.prefix}-ingress-controller")
      }
    }
  }
}
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
    name = "${var.prefix}-INGRESS-CONTROLLER"
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
    name = "${var.prefix}-INGRESS-CONTROLLER"
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
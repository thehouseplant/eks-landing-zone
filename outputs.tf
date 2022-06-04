output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.cluster.id
}

output "cluster_endpoint" {
  description = "EKS control plane endpoint"
  value       = aws_eks_cluster.cluster.endpoint
}

output "cluster_kubeconfig" {
  description = "EKS kubeconfig certificate authority data"
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
}
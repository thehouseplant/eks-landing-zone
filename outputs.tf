output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.cluster.id
}

output "cluster_endpoint" {
  description = "EKS control plane endpoint"
  value       = aws_eks_cluster.cluster.endpoint
}

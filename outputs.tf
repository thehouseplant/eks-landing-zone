output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "EKS control plane endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group IDs attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  description = "kubectl configuration"
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "Kubernetes configuration to authenticate to the EKS cluster"
  value       = module.eks.config_map_aws_auth
}

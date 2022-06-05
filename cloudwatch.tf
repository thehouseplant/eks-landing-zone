resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = lower("/aws/eks/eks-lz-cluster/cluster")
  retention_in_days = 7

  tags = {
    Name = "EKS Landing Zone Cluster Logs"
  }
}

resource "aws_cloudwatch_log_group" "elasticache_logs" {
  name = "${var.prefix}-ELASTICACHE"

  tags = {
    Name = "EKS Landing Zone ElastiCache Logs"
  }
}
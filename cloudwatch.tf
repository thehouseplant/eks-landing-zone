resource "aws_cloudwatch_log_group" "eks_logs" {
  name = "${var.prefix}-EKS"
}

resource "aws_cloudwatch_log_group" "elasticache_logs" {
  name = "${var.prefix}-ELASTICACHE"
}
resource "aws_cloudwatch_log_group" "cluster_logs" {
  name = "${var.prefix}-LOGS"
}
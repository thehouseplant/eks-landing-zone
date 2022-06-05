resource "aws_elasticache_cluster" "cluster" {
  cluster_id           = lower("${var.prefix}-cluster")
  engine               = var.elasticache_engine
  node_type            = var.elasticache_size
  num_cache_nodes      = var.elasticache_node_count
  parameter_group_name = var.elasticache_parameter_group
  engine_version       = var.elasticache_version
  port                 = var.elasticache_port

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.elasticache_logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
}
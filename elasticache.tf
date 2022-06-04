resource "aws_elasticache_cluster" "cluster" {
  cluster_id           = "${prefix}-CLUSTER"
  engine               = var.elasticache_engine
  node_type            = var.elasticache_size
  num_cache_nodes      = var.elasticache_node_count
  parameter_group_name = var.elasticache_parameter_group
  engine_version       = var.elasticache_version
  port                 = var.elasticache_port
}
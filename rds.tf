resource "aws_rds_cluster" "cluster" {
  cluster_identifier           = "${var.prefix}-RDS-CLUSTER"
  engine                       = var.rds_engine
  engine_version               = var.rds_version
  availability_zones           = ["${var.region}a", "${var.region}b", "${var.region}c"]
  database_name                = var.rds_name
  master_username              = var.rds_user
  master_password              = var.rds_pass
  backup_retention_period      = 5
  preferred_backup_window      = "01:00-01:30"
  preferred_maintenance_window = "sun:03:00-sun:03:30"
  deletion_protection          = true
  auto_minor_version_upgrade   = true
}

resource "aws_rds_cluster_instance" "instance" {
  count              = var.rds_count
  identifier         = lower("${var.prefix}-rds-instance-${count.index}")
  cluster_identifier = aws_rds_cluster.cluster.id
  instance_class     = var.rds_size
  engine             = aws_rds_cluster.cluster.engine
  engine_version     = aws_rds_cluster.cluster.engine_version
}
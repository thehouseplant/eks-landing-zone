resource "aws_db_instance" "postgres" {
  identifier                = "eks-test"
  allocated_storage         = 5
  backup_retention_period   = 2
  backup_window             = "01:00-01:30"
  maintenance_window        = "sun:03:00-sun:03:30"
  multi_az                  = true
  engine                    = var.aurora_engine
  engine_version            = var.aurora_version
  instance_class            = var.aurora_size
  db_name                   = "eks-test"
  username                  = "administrator"
  password                  = ""
  port                      = "5432"
  db_subnet_group_name      = ""
  vpc_security_group_ids    = [aws_security_group.rds_sg.id]
  skip_final_snapshot       = true
  final_snapshot_identifier = "eks-test-final"
  publicly_accessible       = false
}

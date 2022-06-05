resource "aws_lb" "ingress" {
  name               = "${var.prefix}-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = []
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.s3_logs.bucket
    prefix  = "alb"
    enabled = true
  }

  tags = {
    Name = "EKS Landing Zone ALB"
  }
}
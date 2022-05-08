# Define the AWS provider
terraform {
  backend "s3" {
    bucket = ""
    key    = "ecs.cluster.test.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = "us-west-2"
}



# Networking resources
# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ECS Cluster VPC"
  }
}

# Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

# Public subnets
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Public Subnet A"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Public Subnet B"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "Public Subnet C"
  }
}

resource "aws_subnet" "public_d" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2d"

  tags = {
    Name = "Public Subnet D"
  }
}

# Public subnet route tables and associations
resource "aws_route_table" "public_a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route Table A"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_a.id
}

resource "aws_route_table" "public_b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route Table B"
  }
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_b.id
}

resource "aws_route_table" "public_c" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route Table C"
  }
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_c.id
}

resource "aws_route_table" "public_d" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route Table D"
  }
}

resource "aws_route_table_association" "public_d" {
  subnet_id      = aws_subnet.public_d.id
  route_table_id = aws_route_table.public_d.id
}

# Public NAT gateways and Elastic IP addresses
resource "aws_eip" "public_a" {
  vpc = true

  tags = {
    Name = "Public EIP A"
  }
}

resource "aws_nat_gateway" "public_a" {
  allocation_id = aws_eip.public_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "Public NAT A"
  }
}

resource "aws_eip" "public_b" {
  vpc = true

  tags = {
    Name = "Public EIP B"
  }
}

resource "aws_nat_gateway" "public_b" {
  allocation_id = aws_eip.public_b.id
  subnet_id     = aws_subnet.public_b.id

  tags = {
    Name = "Public NAT B"
  }
}

resource "aws_eip" "public_c" {
  vpc = true

  tags = {
    Name = "Public EIP C"
  }
}

resource "aws_nat_gateway" "public_c" {
  allocation_id = aws_eip.public_c.id
  subnet_id     = aws_subnet.public_c.id

  tags = {
    Name = "Public NAT C"
  }
}

resource "aws_eip" "public_d" {
  vpc = true

  tags = {
    Name = "Public EIP D"
  }
}

resource "aws_nat_gateway" "public_d" {
  allocation_id = aws_eip.public_d.id
  subnet_id     = aws_subnet.public_d.id

  tags = {
    Name = "Public NAT D"
  }
}

# Private subnets
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Private Subnet A"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Private Subnet B"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "Private Subnet C"
  }
}

resource "aws_subnet" "private_d" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-west-2d"

  tags = {
    Name = "Private Subnet D"
  }
}

# Private subnet route tables and associations
resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Private Route Table A"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Private Route Table B"
  }
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Private Route Table C"
  }
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

resource "aws_route_table" "private_d" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Private Route Table D"
  }
}

resource "aws_route_table_association" "private_d" {
  subnet_id      = aws_subnet.private_d.id
  route_table_id = aws_route_table.private_d.id
}

# Private NAT gateways
resource "aws_nat_gateway" "private_a" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private_a.id

  tags = {
    Name = "Private NAT A"
  }
}

resource "aws_nat_gateway" "private_b" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private_b.id

  tags = {
    Name = "Private NAT B"
  }
}

resource "aws_nat_gateway" "private_c" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private_c.id

  tags = {
    Name = "Private NAT C"
  }
}

resource "aws_nat_gateway" "private_d" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private_d.id

  tags = {
    Name = "Private NAT D"
  }
}



# Cluster resources
# ECR repository
resource "aws_ecr_repository" "repo" {
  name = "ECS-CLUSTER-REPO"
}

# ECS cluster
resource "aws_ecs_cluster" "cluster" {
  name = "ECS-CLUSTER"

  setting {
    name  = "Cluster"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.cluster_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.cluster_logs.name
      }
    }
  }
}

# Auto-scaling group and launch configuration
resource "aws_launch_configuration" "ecs_launch" {
  image_id             = ""
  iam_instance_profile = aws_iam_instance_profile.profile.name
  security_groups      = [aws_security_group.ecs_sg.id]
  user_data            = ""
  instance_type        = "t3.small"
}

resource "aws_autoscaling_group" "ecs_asg" {
  name = "ECS-CLUSTER-ASG"
  vpc_zone_identifier = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
    aws_subnet.private_c.id,
    aws_subnet.private_d.id
  ]
  launch_configuration = aws_launch_configuration.ecs_launch.name

  desired_capacity          = 4
  min_size                  = 4
  max_size                  = 6
  health_check_grace_period = 300
  health_check_type         = "EC2"
}

# Load balancer and target group
resource "aws_lb" "alb" {
  name               = "ECS-CLUSTER-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = []
  subnets            = [for subnet in aws_subnet.public : subnet_id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.s3_logs.bucket
    prefix  = "alb"
    enabled = true
  }

  tags = {
    Name = "ECS-CLUSTER-ALB"
  }
}

resource "aws_lb_target_group" "group" {
  name     = "ECS-CLUSTER-ALB-GROUP"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

# S3 buckets and ACLs
resource "aws_s3_bucket" "s3_logs" {
  bucket = "ecs-test-s3-bucket-logs"

  tags = {
    Name = "ECS Logging Bucket"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3_logs.id
  acl    = "private"
}

# Cloudwatch
resource "aws_cloudwatch_log_group" "cluster_logs" {
  name = "ECS-CLUSTER-LOGS"
}

# KMS
resource "aws_kms_key" "cluster_key" {
  description             = "ClusterKey"
  deletion_window_in_days = 7
}

# Service A
resource "aws_ecs_task_definition" "service_a" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "service-a"
      image     = "service-a"
      cpu       = 1
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b, us-west-2c, us-west-2d]"
  }
}

resource "aws_ecs_service" "service_a" {
  name            = "ECS-SERVICE-A"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.service_a.arn
  desired_count   = 4
  iam_role        = aws_iam_role.service_a.name

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.group.arn
    container_name   = "service-a"
    container_port   = 80
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b, us-west-2c, us-west-2d]"
  }
}



# IAM Resources
resource "aws_iam_role" "service_a" {
  name = "ECS-SERVICE-A-ROLE"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "ECS-SERVICE-A-ROLE"
  }
}

resource "aws_iam_instance_profile" "profile" {
  name = "ECS-SERVICE-A-PROFILE"
  role = aws_iam_role.service_a.name
}



# Security groups
resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

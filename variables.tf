variable "region" {
  description = "AWS region used to deploy resources"
  type        = string
  default     = "us-east-1"
}



# General variables
variable "prefix" {
  description = "Prefix for various resource names"
  type        = string
  default     = "EKS-LZ"
}

variable "default_tags" {
  description = "Default tags for various resources"
  type        = map(string)
  default = {
    Description = "EKS Landing Zone"
    Environment = "POC"
    Contact     = "user@example.com"
  }
}



# Networking variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC that will be deployed"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_size" {
  description = "Size of the subnets that will be created"
  type        = number
  default     = 24
}



# EKS variables
variable "eks_version" {
  description = "Version of Kubernetes to deploy"
  type        = string
  default     = "1.20"
}

variable "eks_node_min" {
  description = "Minimum number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "eks_node_max" {
  description = "Maximum nunber of EKS worker nodes"
  type        = number
  default     = 1
}

variable "eks_node_desired" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "eks_node_size" {
  description = "Size of the EKS worker nodes"
  type        = string
  default     = "m5.large"
}



# Aurora variables
variable "aurora_engine" {
  description = "Database engine to use for Aurora"
  type        = string
  default     = "postgres"
}

variable "aurora_version" {
  description = "Database version to use for Aurora"
  type        = string
  default     = "13.7"
}

variable "aurora_size" {
  description = "Size of the Aurora instance"
  type        = string
  default     = "db.t3.small"
}

variable "aurora_user" {
  description = "Name of the administrator user for Aurora"
  type        = string
  default     = "administrator"
}



# ElastiCache variables
variable "elasticache_engine" {
  description = "Database engine to use for ElastiCache"
  type        = string
  default     = "redis"
}

variable "elasticache_version" {
  description = "Database version to use for ElastiCache"
  type        = string
  default     = "3.2.10"
}

variable "elasticache_parameter_group" {
  description = "Database parameter group to use for ElastiCache"
  type        = string
  default     = "default.redis3.2"
}

variable "elasticache_size" {
  description = "Size of the ElastiCache instance"
  type        = string
  default     = "cache.t2.small"
}

variable "elasticache_node_count" {
  description = "Number of ElastiCache nodes to run"
  type        = number
  default     = 1
}

variable "elasticache_port" {
  description = "Database port to use for ElastiCache"
  type        = number
  default     = 6379
}
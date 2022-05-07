# Define the AWS provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = "us-west-2"
}



# Networking
# VPC
resources "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}
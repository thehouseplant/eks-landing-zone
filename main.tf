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
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

# Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

# Public subnets
resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Public Subnet A"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Public Subnet B"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "Public Subnet C"
  }
}

resource "aws_subnet" "public_d" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2d"

  tags = {
    Name = "Public Subnet D"
  }
}

# Private subnets
resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Private Subnet A"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Private Subnet B"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "Private Subnet C"
  }
}

resource "aws_subnet" "private_d" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-west-2d"

  tags = {
    Name = "Private Subnet D"
  }
}
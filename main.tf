# Define the AWS provider
terraform {
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

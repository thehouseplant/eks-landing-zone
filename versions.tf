terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    kubernetes = {
      source  = "hashicorp/terraform"
      version = ">= 2.11.0"
    }
  }

  required_version = ">= 0.14"
}
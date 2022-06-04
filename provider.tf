provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Description = "EKS Landing Zone"
      Environment = "POC"
      Contact     = "user@example.com"
    }
  }
}
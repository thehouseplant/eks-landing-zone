resource "aws_s3_bucket" "s3_logs" {
  bucket = lower("${var.prefix}-s3-bucket-logs")

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        ssl_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "EKS Logging Bucket"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3_logs.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.s3_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
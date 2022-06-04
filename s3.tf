resource "aws_s3_bucket" "s3_logs" {
  bucket = lower("${var.prefix}-s3-bucket-logs")

  tags = {
    Name = "EKS Logging Bucket"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3_logs.id
  acl    = "private"
}
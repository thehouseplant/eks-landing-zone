resource "aws_acm_certificate" "cert" {
  domain_name       = "example.com"
  validation_method = "DNS"
  subject_alternative_names = [
    "app.example.com",
    "api.example.com"
  ]

  lifecycle {
    create_before_destroy = true
  }
}
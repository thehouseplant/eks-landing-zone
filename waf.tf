# Default WAF ACI rule
resource "aws_wafv2_web_aci" "aci_default" {
  name        = "${var.prefix}-WAF-DEFAULT"
  description = "Default WAF ACI rule"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "default"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_QUERYSTRING"
        }

        excluded_rule {
          name = "NoUserAgent_HEADER"
        }

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "default-metrics"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Name = "Default WAF ACI"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "default-metrics"
    sampled_requests_enabled   = false
  }
}



# Rate-limited WAF ACI rule
resource "aws_wafv2_web_aci" "aci_limited" {
  name        = "${var.prefix}-WAF-LIMITED"
  description = "Rate-limited WAF ACI rule"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "limited"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"

        scope_down_statement {
          geo_match_statement {
            country_codes = ["RU"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "default-metrics"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Name = "Default WAF ACI"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "default-metrics"
    sampled_requests_enabled   = false
  }
}
#Cloudfront
resource "aws_cloudfront_distribution" "main" {
  http_version          = "http2"
  enabled               = true
  wait_for_deployment   = false
  is_ipv6_enabled       = true

  origin {
    domain_name           = var.s3_domain_name
    origin_id             = var.s3_bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  default_cache_behavior {
    target_origin_id            = var.s3_bucket_id
    allowed_methods             = ["GET", "HEAD"]
    cached_methods              = ["GET", "HEAD"]
    compress                    = true
    viewer_protocol_policy      = "redirect-to-https"

    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type    = "none"
    }
  }
}

# OAC
resource "aws_cloudfront_origin_access_control" "main" {
  name        = "main"
  description = "main"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}
#Cloudfront
resource "aws_cloudfront_distribution" "main" {
  http_version          = "http2"
  enabled               = false
  wait_for_deployment   = false
  is_ipv6_enabled       = true

  aliases =  [
    var.domain_name
  ]

  origin {
    domain_name           = var.s3_domain_name
    origin_id             = var.s3_bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
  }

  # viewer_certificate {
  #   cloudfront_default_certificate = true
  # }

  default_cache_behavior {
    target_origin_id            = var.s3_bucket_id
    allowed_methods             = ["GET", "HEAD"]
    cached_methods              = ["GET", "HEAD"]
    compress                    = true
    viewer_protocol_policy      = "redirect-to-https"

    # 3つのポリシーを設定
    cache_policy_id            = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"  # CachingDisabled
    origin_request_policy_id   = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"  # CORS-S3Origin
    response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c"  # SimpleCORS
  }

  restrictions {
    geo_restriction {
      restriction_type    = "whitelist"
      locations           = ["JP"]
    }
  }

  # ssl certificate
  viewer_certificate {
    acm_certificate_arn      = var.acm_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
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
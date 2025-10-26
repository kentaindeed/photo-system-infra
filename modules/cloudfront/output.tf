# cloudfront distribution DNS
output "distribution_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

# cloudfront arn
output "distribution_arn" {
  value = aws_cloudfront_distribution.main.arn
}

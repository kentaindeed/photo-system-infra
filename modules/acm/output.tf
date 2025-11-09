# acm output

output "acm_certificate_arn" {
  value = data.aws_acm_certificate.ssl-cert.arn
  description = "my domain acm output"
}
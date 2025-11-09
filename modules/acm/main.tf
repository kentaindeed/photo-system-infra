# 既存のACM を使用する（us-east-1リージョン）
# CloudFrontで使用するACM証明書は必ずus-east-1に存在する必要があります

data "aws_acm_certificate" "ssl-cert" {
    domain   = var.domain
    statuses = ["ISSUED"]
}

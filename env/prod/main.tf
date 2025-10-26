


# s3 module
module "s3" {
    source = "../../modules/s3"
    env = var.env
}

# backend S3
module "backend" {
    source = "../../modules/backend"   
}

# cloudfront module
module "cloudfront" {
    source = "../../modules/cloudfront"
    env = var.env
    s3_domain_name = module.s3.s3-bucket-domain-name
    s3_bucket_id = module.s3.photo-bucket-id
}

# S3
#バケットポリシー（CloudFrontからのアクセス許可）
resource "aws_s3_bucket_policy" "cloudfront_policy" {
    bucket = module.s3.photo-bucket-id
    policy = data.aws_iam_policy_document.cloudfront_bucket_policy.json
}

data "aws_iam_policy_document" "cloudfront_bucket_policy" {
    statement {
        principals {
            type = "Service"
            identifiers = ["cloudfront.amazonaws.com"]
        }
        actions = [
            "s3:GetObject"
        ]
        resources = [
            "${module.s3.photo-bucket-arn}/*"
        ]
        condition {
            test = "StringEquals"
            variable = "AWS:SourceArn"
            values = [module.cloudfront.distribution_arn]
        }
    }
}
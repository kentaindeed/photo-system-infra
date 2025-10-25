


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
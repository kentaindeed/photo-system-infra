


# s3 module
module "s3" {
    source = "../../modules/s3"
    env = var.env
}

# backend S3
module "backend" {
    source = "../../modules/backend"   
}
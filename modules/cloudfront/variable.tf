variable "env" {
    type = string
    default = "prod"
}

variable "s3_domain_name" {
    description = "S3 bucket domain name"
    type = string
}

variable "s3_bucket_id" {
    description = "S3 bucket id"
    type = string
}

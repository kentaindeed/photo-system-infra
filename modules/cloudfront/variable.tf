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

variable "domain_name" {
    description = "Domain name"
    type = string
}

variable "acm_arn" {
    description = "SSL certificate ARN"
    type = string
}
# s3 output
output "s3-bucket-domain-name" {
    value = aws_s3_bucket.photo-bucket.bucket_domain_name
}
# bucket id
output "photo-bucket-id" {
    value = aws_s3_bucket.photo-bucket.id
}

# bucket arn
output "photo-bucket-arn" {
    value = aws_s3_bucket.photo-bucket.arn
}


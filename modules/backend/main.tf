# backend s3

resource "aws_s3_bucket" "backend_s3" {
  bucket = "prod-tfstate-photo-system-bucket"
  tags = {
    Name = "prod-tfstate-photo-system-bucket"
  }
}

# versioing
resource "aws_s3_bucket_versioning" "backend_s3_versioning" {
  bucket = aws_s3_bucket.backend_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

# encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "backend_s3_encryption" {
  bucket = aws_s3_bucket.backend_s3.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# public access control
resource "aws_s3_bucket_public_access_block" "backend_s3_public_access" {
  bucket = aws_s3_bucket.backend_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




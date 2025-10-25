# s3 maintf
locals {
  common_variables = {
    region = "ap-northeast-1"
    profile = "default"
  }

  common_tags = {
    Environment = "dev"
    Project = "photo-system"
    Owner = "kentaindeed"
    CreatedBy = "terraform"
    CreatedAt = "2025-01-01"
  }

  availability_zones = [
    "ap-northeast-1a", 
    "ap-northeast-1d", 
    "ap-northeast-1c"
]
    # 名前のプレフィックスを定義
    name_prefix = "${local.common_tags.Environment}-${local.common_tags.Project}"
}


resource "aws_s3_bucket" "photo-bucket" {
    bucket = "${local.name_prefix}-bucket"

    tags = {
        Name = "${local.name_prefix}-bucket"
    }
}

resource "aws_s3_bucket_public_access_block" "s3_buckets_access" {
  bucket = aws_s3_bucket.photo-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "maintf" {
    bucket = aws_s3_bucket.maintf.id

    versioning_configuration {
        status = "disabled"
    }
}
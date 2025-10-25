terraform {
  backend "s3" {
    bucket         = "prod-tfstate-photo-system-bucket"
    key            = "prod/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    
  }
}
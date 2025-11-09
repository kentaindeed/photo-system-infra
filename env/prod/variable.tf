variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "env" {
  type    = string
  default = "prod"
}

variable "domain" {
  type    = string
  description = "domain name for the website"
}


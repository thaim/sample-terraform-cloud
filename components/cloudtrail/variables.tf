variable "aws_profile" {
  type    = "string"
  default = "default"
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type = "string"
  default = "ap-northeast-1"
}


data "aws_caller_identity" "current" {}

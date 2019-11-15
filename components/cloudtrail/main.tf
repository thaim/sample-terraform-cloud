terraform {
  backend "s3" {
    // 以下のパラメタは backend.tfvarsで指定する
    // bucket = "tfstate-bucket-name"
    // key = "tfstate-key-name"
  }

  required_version = "= 0.12.13"
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = var.aws_profile
  # profile = "spacely"
}


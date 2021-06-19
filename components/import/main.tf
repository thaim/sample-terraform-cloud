terraform {
  required_version = "= 0.13.5"

  backend "remote" {
    organization = "thaim"

    workspaces {
      name = "sample-import-resource"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

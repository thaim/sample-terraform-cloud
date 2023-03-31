terraform {
  backend "remote" {
    organization = "thaim"
    workspaces {
      name = "oidc"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.54.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "thaim"

  default_tags {
    tags = {
      repo = "github.com/thaim/sample-terraform-cloud/components/oidc"
    }
  }
}

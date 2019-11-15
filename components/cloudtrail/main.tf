terraform {
  backend "remote" {
    organization = "thaim"

    workspaces {
      name = "sample-tfc-cloudtrail"
    }
  }

  required_version = "= 0.12.13"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

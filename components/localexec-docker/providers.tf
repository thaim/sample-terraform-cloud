terraform {
  backend "remote" {
    organization = "thaim"
    workspaces {
      name = "local-exec"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

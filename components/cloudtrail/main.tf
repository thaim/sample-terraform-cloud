terraform {
  backend "remote" {
    organization = "thaim"
  }

  workspaces {
    name = "sample-tfc-cloudtrail"
  }

  required_version = "= 0.12.13"
}

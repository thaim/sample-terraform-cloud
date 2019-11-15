terraform {
  backend "remote" {
    organization = "thaim"

    workspace {
      name = "sample-tfc-cloudtrail"
    }
  }

  required_version = "= 0.12.13"
}

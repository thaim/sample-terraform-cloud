terraform {
  backend "remote" {
    organization = "thaim"

    workspaces {
      name = "sample-import-resource"
    }
  }
}


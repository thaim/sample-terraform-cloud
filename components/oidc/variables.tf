variable "tfc_organization_name" {
  type = string
}

variable "tfc_project_name" {
  type = string
}

variable "tfc_workspace_name" {
  type = string
}

variable "gha_oidc_repos" {
  type = list(string)
}

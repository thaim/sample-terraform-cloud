variable "aws_profile" {
  type    = "string"
  default = "default"
}


data "aws_caller_identity" "current" {}

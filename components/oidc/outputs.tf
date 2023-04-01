output "tfc_role" {
  value = aws_iam_role.tfc_role.arn
}

output "gha_role" {
  value = aws_iam_role.gha_deploy.arn
}

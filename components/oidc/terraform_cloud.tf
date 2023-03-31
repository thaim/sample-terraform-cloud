resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url             = data.tls_certificate.tfc_certificate.url
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = [data.tls_certificate.tfc_certificate.certificates[0].sha1_fingerprint]
}

data "tls_certificate" "tfc_certificate" {
  url = "https://app.terraform.io"
}

# Terraform Cloud がAWSへの接続時に利用するIAMロール
resource "aws_iam_role" "tfc_role" {
  name               = "tfc-role"
  assume_role_policy = data.aws_iam_policy_document.assume_tfc.json
}

data "aws_iam_policy_document" "assume_tfc" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.tfc_provider.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = [one(aws_iam_openid_connect_provider.tfc_provider.client_id_list)]
    }
    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values   = ["organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "administrator_access" {
  role       = aws_iam_role.tfc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Terraform Cloudに作成する認証情報
resource "tfe_variable_set" "aws_oidc" {
  name = "AWS OIDC Authentication"
  organization = var.tfc_organization_name
}

resource "tfe_variable" "provider_auth" {
  key = "TFC_AWS_PROVIDER_AUTH"
  value = true
  category = "env"
  variable_set_id = tfe_variable_set.aws_oidc.id
}

resource "tfe_variable" "run_role_arn" {
  key = "TFC_AWS_RUN_ROLE_ARN"
  value = aws_iam_role.tfc_role.arn
  category = "env"
  variable_set_id = tfe_variable_set.aws_oidc.id
}

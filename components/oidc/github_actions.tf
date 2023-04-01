resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = data.tls_certificate.github_actions.url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.github_actions.certificates[*].sha1_fingerprint
}

data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}


resource "aws_iam_role" "gha_deploy" {
  name               = "github-actions-deploy"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = formatlist("repo:thaim/%s:*", var.gha_oidc_repos)
    }
  }
}


resource "aws_iam_role_policy_attachment" "gha_s3" {
  role       = aws_iam_role.gha_deploy.name
  policy_arn = aws_iam_policy.upload_s3.arn
}

resource "aws_iam_policy" "upload_s3" {
  name   = "AllowUploadS3Object"
  policy = data.aws_iam_policy_document.upload_s3.json
}

data "aws_iam_policy_document" "upload_s3" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:PutObject"
    ]
    resources = ["*"]
  }
}

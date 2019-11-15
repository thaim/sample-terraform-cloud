resource "aws_cloudtrail" "main" {
  name           = "thaim-cloudtrail"
  s3_bucket_name = "${aws_s3_bucket.cloudtrail.id}"

  is_multi_region_trail = true
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket = "thaim-cloudtrail"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = "${aws_s3_bucket.cloudtrail.id}"

  # ポリシーで許可するリソースの指定を変数を用いて可変にしたい
  # このためヒアドキュメントや外部ファイルではなくHCL記述する
  policy = "${data.aws_iam_policy_document.cloudtrail_store_s3.json}"
}

# バケットポリシーは公式ドキュメントの推奨設定に従う
# https://docs.aws.amazon.com/ja_jp/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
data "aws_iam_policy_document" "cloudtrail_store_s3" {
  statement {
    sid    = "AllowCloudTrailToCheckACL"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [
      "${aws_s3_bucket.cloudtrail.arn}"
    ]
    actions = [
      "s3:GetBucketAcl"
    ]
  }
  statement {
    sid    = "AllowCloudTrailToWriteLog"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [
      "${aws_s3_bucket.cloudtrail.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]
    actions = [
      "s3:PutObject"
    ]
    condition {
      test = "StringEquals"
      variable = "s3:x-amz-acl"
      values = [
        "bucket-owner-full-control"
      ]
    }
  }
}

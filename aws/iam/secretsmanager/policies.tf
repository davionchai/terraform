data "aws_iam_policy_document" "general_de_secrets_manager_policy_document" {
  statement {
    actions = [
      "secretsmanager:GetRandomPassword",
      "secretsmanager:ListSecrets",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
    ]

    resources = [
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Owner"
      values   = ["${var.owner_email}"]
    }
  }

  statement {
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Owner"
      values   = ["${var.owner_email}"]
    }
  }
}

resource "aws_secretsmanager_secret_policy" "general_de_secrets_manager_policy" {
  secret_arn = aws_secretsmanager_secret.example.arn
  policy     = data.aws_iam_policy_document.general_de_secrets_manager_policy_document.json
}

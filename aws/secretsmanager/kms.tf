resource "aws_kms_key" "general_de_kms_key" {
  description = "General kms key for AWS Secrets Manager"
  tags = {
    Owner       = "${var.owner_email}"
    Environment = "playground"
    ManagedBy   = "Terraform"
  }
}

resource "aws_kms_alias" "general_de_kms_alias" {
  name          = "alias/general-de-kms-alias"
  target_key_id = aws_kms_key.general_de_kms_key.key_id
}

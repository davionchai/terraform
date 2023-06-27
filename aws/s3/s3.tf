module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "de-superset"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  tags = {
    Owner       = "${var.owner_email}"
    Environment = "development"
    ManagedBy   = "Terraform"
  }
}
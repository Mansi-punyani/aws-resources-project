module "s3_bucket_private-bucket" {
  source = "./.terraform/modules/terraform-aws-s3-bucket"

  bucket = "${var.environment}-cogniwide-private-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "s3_bucket_public-bucket" {
  source = "./.terraform/modules/terraform-aws-s3-bucket"

  bucket = "${var.environment}-cogniwide-public-s3-bucket"
  acl    = "public-read"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
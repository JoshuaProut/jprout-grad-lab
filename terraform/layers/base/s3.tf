locals {
  resource_prefix = "${var.project}-${var.environment}"
}


module "s3_webfiles" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${local.resource_prefix}-s3-webfiles"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

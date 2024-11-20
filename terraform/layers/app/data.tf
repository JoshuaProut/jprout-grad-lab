// Get S3 bucket data
data "aws_s3_bucket" "s3_webfiles" {
  bucket = "${local.resource_prefix}-s3-webfiles"
}



resource "aws_s3_object" "object" {
  bucket = "${local.resource_prefix}-s3-webfiles"
  key    = "index.html"
  source = "src/index.html"
}

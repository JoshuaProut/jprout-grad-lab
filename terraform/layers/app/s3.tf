

resource "aws_s3_object" "s3_webfiles_object" {
  bucket = data.aws_s3_bucket.s3_webfiles.id
  key    = "index.html"
  source = "src/index.html"
}

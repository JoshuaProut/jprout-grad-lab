resource "aws_s3_bucket" "codepipeline_artifcats" {
  bucket = "${var.environment}-${var.project}-codepipeline-bucket"
}

resource "aws_s3_bucket_versioning" "codepipeline_versioning" {
  bucket = aws_s3_bucket.codepipeline_artifcats.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

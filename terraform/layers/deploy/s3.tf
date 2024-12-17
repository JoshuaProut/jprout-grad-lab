resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = "${var.environment}-${var.project}-codepipeline-bucket"
}

resource "aws_s3_bucket_versioning" "codepipeline_versioning" {
  bucket = aws_s3_bucket.codepipeline_artifacts.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "copepipeline_ownership" {
  bucket = aws_s3_bucket.codepipeline_artifacts.bucket

  rule {
    object_ownership = "ObjectWriter"
  }
}


resource "aws_codebuild_project" "codebuild_base" {

  name = "${var.environment}-${var.project}-base-codebuild"

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild.standard:7.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = templatefile("src/buildspec.yml", {})
  }
}

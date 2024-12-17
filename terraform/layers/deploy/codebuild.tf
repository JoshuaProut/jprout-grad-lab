resource "aws_codebuild_project" "codebuild_base" {

  name = "${var.environment}-${var.project}-base-codebuild"

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = var.codebuild_node_size
    image                       = var.codebuild_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  source {
    type = "CODEPIPELINE"
    buildspec = templatefile("src/buildspec.yml", {
      environment = var.environment
      tf_version  = var.tf_version
    })
  }
}

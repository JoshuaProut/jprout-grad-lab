resource "aws_codepipeline" "codepipeline_deploy" {
  name           = "${var.environment}-${var.project}-pipeline-deploy"
  role_arn       = aws_iam_role.codepipeline_role.arn
  pipeline_type  = "V2"
  execution_mode = "QUEUED"

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "${var.github_org}-${var.github_repo}"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = 1
      output_artifacts = ["source_tf_output"]
      region           = var.region

      configuration = {
        ConnectionArn    = data.aws_codestarconnections_connection.codestar_connection.arn
        FullRepositoryId = "${var.github_org}/${var.github_repo}"
        BranchName       = var.github_branch
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name             = "BuildBase"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_tf_output"]
      output_artifacts = ["base_build_output"]
      version          = 1

      configuration = {
        ProjectName = "${var.environment}-${var.project}-base-codebuild"
      }
    }

    action {
      name             = "BuildApp"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_tf_output"]
      output_artifacts = ["app_build_output"]
      version          = 1

      configuration = {
        ProjectName = "${var.environment}-${var.project}-app-codebuild"
      }
    }
  }
}

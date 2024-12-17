// Codestar ------------------------------------
data "aws_codestarconnections_connection" "codestar_connection" {
  name = "${var.project}-github-connection"
}

// Codepipeline --------------------------------

data "aws_iam_policy_document" "codepipeline_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "codestar-connections:UseConnection"
    ]

    resources = [
      data.aws_codestarconnections_connection.codestar_connection.arn
    ]
  }
}

// CodePipeline ----------------
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.environment}-${var.project}-codepipeline-role"

  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_policy.json
}

resource "aws_iam_policy" "codepipeline_policy" {
  name   = "${var.environment}-${var.project}-codepipeline-policy"
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_iam_role_policy_attachment" "codepipeline_attachment" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}



// CodeBuild ----------------

resource "aws_iam_role" "codebuild_role" {
  name               = "${var.environment}-${var.project}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_policy.json
}

resource "aws_iam_policy" "codebuild_policy" {
  name   = "${var.environment}-${var.project}-codebuild-policy"
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role_policy_attachment" "codebuild_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

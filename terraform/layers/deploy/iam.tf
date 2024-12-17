// Create IAM role
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.environment}-${var.project}-codepipeline-role"

  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role.json
}

// Create policy
resource "aws_iam_policy" "codepipeline_policy" {
  name   = "${var.environment}-${var.project}-codepipeline-policy"
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_iam_role_policy_attachment" "codepipeline_attachment" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}


locals {
  resource_prefix = "${var.project}-${var.environment}"
}

// Create IAM role
resource "aws_iam_role" "s3_webfiles_access" {
  name = "${local.resource_prefix}_s3_webfiles_access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

// Create IAM policy allowing access to S3 bucket 
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${local.resource_prefix}_s3_access_policy"
  description = "Allows EC2 instance to access web files S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${data.aws_s3_bucket.s3_webfiles.arn}",
          "${data.aws_s3_bucket.s3_webfiles.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "${local.resource_prefix}-web-instance-profile"
  role = aws_iam_role.s3_webfiles_access.name
}

resource "aws_iam_role_policy_attachment" "web_role_attach" {
  role       = aws_iam_role.s3_webfiles_access.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

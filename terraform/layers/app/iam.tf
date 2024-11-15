// Find base module
module "base" {
  source = "../base"
}

output "s3_name" {
  value = module.base.s3_webfiles_arn
}

// Create IAM role
resource "aws_iam_role" "s3_webfiles_access" {
  name = "s3_webfiles_access"

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
  name        = "S3AccessPolicy"
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
          "${module.base.s3_webfiles_arn}",
          "${module.base.s3_webfiles_arn}/*"
        ]
      }
    ]
  })
}

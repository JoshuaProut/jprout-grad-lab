// Get S3 bucket data
data "aws_s3_bucket" "s3_webfiles" {
  bucket = "${local.resource_prefix}-s3-webfiles"
}

// Get most recent AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
}

// VPC data
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix}-vpc"]
  }
}

// Public subnet data
data "aws_subnets" "vpc_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix}-vpc-public-*"]
  }


}

// Private subnet data
data "aws_subnets" "vpc_private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix}-vpc-private-*"]
  }

}

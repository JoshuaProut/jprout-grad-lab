// Project --------------


variable "project" {
  description = "The name of the project"
  type        = string
  default     = "grad-lab-1"
}

variable "environment" {
  description = "The environment of the resource"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Region for launch of resources"
  type        = string
  default     = "eu-west-2"
}

variable "tf_version" {
  description = "Version of Terraform to be used"
  type        = string
  default     = "1.9.8"
}


// Github -------------

variable "github_org" {
  description = "Github organisation name"
  type        = string
  default     = "JoshuaProut"
}

variable "github_repo" {
  description = "Github repo name"
  type        = string
  default     = "jprout-grad-lab"
}

variable "github_branch" {
  description = "Github branch to pull from"
  type        = string
  default     = "main"
}

// Codebuild ---------


variable "codebuild_node_size" {
  description = "Node size"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_image" {
  description = "Codebuild image"
  type        = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
}

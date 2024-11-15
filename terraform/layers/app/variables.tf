variable "project" {
  description = "The name of the project"
  type        = string
  default     = "grad-lab-1"
}

variable "environment" {
  description = "The environement of the resource"
  type        = string
  default     = "Dev"
}

variable "region" {
  description = "Region for launch of resources"
  type        = string
  default     = "eu-west-2"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "Grad-lab-1"
}

variable "environment" {
  description = "The environment of the resource"
  type        = string
  default     = "Dev"
}

variable "cidr" {
  description = "CIDR of the VPC to be created"
  type        = string
  default     = "10.0.0.0/16"
}

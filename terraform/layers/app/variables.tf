variable "project" {
  description = "The name of the project"
  type        = string
  default     = "grad-lab-1"
}

variable "environment" {
  description = "The environement of the resource"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Region for launch of resources"
  type        = string
  default     = "eu-west-2"
}

variable "instance_type" {
  description = "Type of the web instances launched by auto scaling group"
  type        = string
  default     = "t2.micro"
}

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
  
variable "cidr" {
  description = "CIDR of the VPC to be created"
  type        = string
  default     = "10.0.0.0/16"

}

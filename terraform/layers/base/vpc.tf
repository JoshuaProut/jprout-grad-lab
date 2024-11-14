// Get names of the available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs  = data.aws_availability_zones.available.names
  cidr = "10.0.0.0/16"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dev-vpc"
  cidr = local.cidr


  azs             = local.azs
  private_subnets = [for k, _ in local.azs : cidrsubnet(local.cidr, 3, k)]
  public_subnets  = [for k, _ in local.azs : cidrsubnet(local.cidr, 3, k + 4)]


  enable_nat_gateway = true
  single_nat_gateway = var.environment == "Dev" ? true : false



}

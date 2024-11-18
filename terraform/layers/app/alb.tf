// VPC data
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix}-vpc"]
    //values = ["grad-lab-1-dev-vpc"]
  }
}

// Subnet data
data "aws_subnets" "vpc_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}


// Security group rules
resource "aws_security_group" "alb_sg" {
  name   = "${local.resource_prefix}-alb-sg"
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_alb_http_in" {

  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_alb_https_in" {

  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_alb_all_out" {
  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1

  from_port = 0
  to_port   = 0

}

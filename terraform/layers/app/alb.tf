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
  ip_protocol = "-1"

}

module "public_alb" {

  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name   = "${local.resource_prefix}-alb"
  vpc_id = data.aws_vpc.vpc.id

  subnets         = data.aws_subnets.vpc_public_subnets.ids
  security_groups = [aws_security_group.alb_sg.id]

  load_balancer_type    = "application"
  create_security_group = false


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix      = "web-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true
        path                = "/"
        protocol            = "HTTP"
        interval            = 300
        matcher             = 200
        timeout             = 120
        unhealthy_threshold = 5
      }
      create_attachment = false
    }
  ]
}


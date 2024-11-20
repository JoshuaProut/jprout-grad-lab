// Data source to retrieve AMI ID

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
}

// EC2 security group

resource "aws_security_group" "web_instances_sg" {
  name        = "${local.resource_prefix}-web-instance-sg"
  description = "Allow HTTP traffic connection to the load balancer"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_in" {
  security_group_id = aws_security_group.web_instances_sg.id

  referenced_security_group_id = module.aws_security_group.alb_sg.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "allow_all_out" {
  security_group_id = aws_security_group.web_instances_sg.id

  referenced_security_group_id = module.aws_security_group.alb_sg.id

  from_port   = 0
  to_port     = 0
  ip_protocol = "tcp"
}


resource "aws_launch_template" "web_instances" {
  name                   = "${local.resource_prefix}-launch-template"
  image_id               = data.aws_ami.amazon_linux_2.image_id
  vpc_security_group_ids = [aws_security_group.web_instances_sg]
  instance_type          = var.instance_type

}

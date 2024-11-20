// EC2 security group

resource "aws_security_group" "web_instances_sg" {
  name        = "${local.resource_prefix}-web-instance-sg"
  description = "Allow HTTP traffic connection to the load balancer"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_in" {
  security_group_id = aws_security_group.web_instances_sg.id

  //referenced_security_group_id = aws_security_group.alb_sg.id

  referenced_security_group_id = aws_security_group.alb_sg.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "allow_all_out" {
  security_group_id = aws_security_group.web_instances_sg.id

  referenced_security_group_id = aws_security_group.alb_sg.id

  from_port   = 0
  to_port     = 0
  ip_protocol = "tcp"
}


resource "aws_launch_template" "web_launch_template" {
  name                   = "${local.resource_prefix}-launch-template"
  image_id               = data.aws_ami.amazon_linux_2.image_id
  vpc_security_group_ids = [aws_security_group.web_instances_sg.id]
  instance_type          = var.instance_type
}


resource "aws_autoscaling_group" "web_asg" {
  name = "${local.resource_prefix}-web-asg"

  min_size = 2
  max_size = 3

  target_group_arns   = module.public_alb.target_group_arns
  vpc_zone_identifier = data.aws_subnets.vpc_private_subnets.ids
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.resource_prefix}-web-instance"
    propagate_at_launch = true
  }
}

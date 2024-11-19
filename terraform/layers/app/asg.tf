// Data source to retrieve AMI ID

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
}

output "latest_amazon_linux" {
  value = data.aws_ami.amazon_linux_2.id
}


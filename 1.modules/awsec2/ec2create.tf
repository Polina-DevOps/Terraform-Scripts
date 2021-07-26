## This script to create AWS EC2 Instance creation"

resource "aws_instance" "instance0" {
  ami           	      = "ami-074df373d6bafa625"
  instance_type 	      = "t2.micro"
  vpc_security_group_ids  = [var.SG_ID]

  tags 				= {
    Name			= "instance0"
  }
}

variable "SG_ID" {}

output "AWS_PRIVATEIP" {
  value = aws_instance.instance0.private_ip
}
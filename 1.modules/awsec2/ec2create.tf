## This script to create AWS EC2 Instance creation"

resource "aws_instance" "instance" {
  ami           	      = "ami-074df373d6bafa625"
  instance_type 	      = "t2.micro"
  vpc_security_group_ids  = [var.SG_ID]

  tags 				= {
    Name			= "instance ${count.index}"
  }
}

variable "SG_ID" {}

output "AWS_PRIVATEIP" {
  value = aws_instance.instance.private_ip
}
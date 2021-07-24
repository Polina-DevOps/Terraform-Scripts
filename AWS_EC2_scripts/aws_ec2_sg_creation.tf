## To create AWS SG and EC2 instance using Terraform

resource "aws_instance" "sampleserver" {
  ami           	= "ami-074df373d6bafa625"
  instance_type 	= "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_all.id]

  tags 				= {
    Name			= "sampleserver"
  }
}

resource "aws_security_group" "allow_ssh_all" {
  name        		= "allow_ssh_all"
  description 		= "Allow SSH inbound traffic"

  ingress {
    description     = "SSH from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags 				= {
    Name 			= "allow_ssh_all"
  }
}

# Configure the AWS Provider
provider "aws" {
  region            = "us-east-1"
}
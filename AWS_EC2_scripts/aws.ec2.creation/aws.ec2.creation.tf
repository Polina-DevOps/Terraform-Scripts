## This script to create AWS EC2 Instance creation"

resource "aws_instance" "testinstance" {
  ami           	= "ami-074df373d6bafa625"
  instance_type 	= "t2.micro"

  tags 				= {
    Name			= "testinstance"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
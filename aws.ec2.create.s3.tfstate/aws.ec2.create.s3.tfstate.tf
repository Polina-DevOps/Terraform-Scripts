## To create AWS ec2 instance with tfstate file in s3 bucket

resource "aws_instance" "instance0" {
  ami                   = "ami-074df373d6bafa625"
  instance_type         = "t2.micro"

  tags                          = {
    Name                        = "instance0"
  }
}

resource "aws_instance" "instance1" {
  ami                   = "ami-074df373d6bafa625"
  instance_type         = "t2.micro"

  tags                          = {
    Name                        = "instance1"
  }
}

terraform {
  backend "s3" {
    bucket = "polina-terraform"
    key    = "sample/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

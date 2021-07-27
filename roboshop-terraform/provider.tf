## Define AWS provider details

terraform {
  backend "s3" {
    bucket         = "polina-terraform"
    key            = "roboshop/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform"
  }
}

# Configure the AWS Provider
provider "aws" {
  region           = "us-east-1"
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

## Configure terraform.tfstate to aws s3 bucket

terraform {
  backend "s3" {
    bucket = "polina-devops"
    key    = "roboshop/practice-init/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform"
  }
}
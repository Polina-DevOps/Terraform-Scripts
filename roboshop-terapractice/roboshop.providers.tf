# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

## Configure terraform.tfstate to aws s3 bucket

terraform {
  backend "s3" {
    bucket = "polina-terraform"
    key    = "roboshop/practice-init/"
    region = "us-east-1"
    dynamodb_table = "terraform"
  }
}

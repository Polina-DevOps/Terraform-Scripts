## Main or root module file

terraform {
  backend "s3" {
    bucket = "polina-terraform"
    key    = "sample/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform"
  }
}

module "EC2_SAMPLE" {
  depends_on    = [module.SG_SAMPLE]
  source        = "./awsec2"
  SG_ID         = module.SG_SAMPLE.SG_ID
}

module "SG_SAMPLE" {
  source        = "./awssg"
}

provider "aws" {
  region        = "us-east-1"
}

output "AWS_PRIVATE_IP" {
  value         = module.EC2_SAMPLE.AWS_PRIVATE_IP
}
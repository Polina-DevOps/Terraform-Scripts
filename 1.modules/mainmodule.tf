## Main or root module file

module "EC2_SAMPLE" {
  count = 3
  depends_on = [module.SG_SAMPLE]
  source = "./awsec2"
  SG_ID  = module.SG_SAMPLE.SG_ID
}

module "SG_SAMPLE" {
  source = "./awssg"
}

provider "aws" {
  region = "us-east-1"
}

output "AWS_PRAVITEIP" {
  value = module.EC2_SAMPLE.AWS_PRIVATEIP
}
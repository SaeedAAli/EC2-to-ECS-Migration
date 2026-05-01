module "vpc" {
  source = "./vpc"
}

module "security_group" {
  source = "./security_group"
  vpc = module.vpc.vpc
}



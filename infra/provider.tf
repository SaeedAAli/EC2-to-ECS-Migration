terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket       = "ec2toecsmigration"
    region       = "eu-west-2"
    key          = "terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}

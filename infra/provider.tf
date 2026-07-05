terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.52.0"
    }
    cloudfare = {
      source = "cloudfare/cloudfare"
      version = "~> 5"

    }
  }
}
provider "aws" {
  region = "eu-west-2"
}

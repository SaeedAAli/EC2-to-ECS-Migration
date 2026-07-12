terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.52.0"
}
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"

    }
  }
}
provider "aws" {
  region = "eu-west-2"
}

provider "cloudflare" {}

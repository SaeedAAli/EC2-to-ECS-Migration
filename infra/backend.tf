terraform {
  backend "s3" {
    region = "eu-west-2"
     bucket = "ec2toecsmigration"
     encrypt = true
     use_lockfile = true
     key = "terraform.tfstate"
  }
}
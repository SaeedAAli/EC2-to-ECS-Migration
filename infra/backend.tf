terraform {
  backend "s3" {
    region = "eu-west-2"
    key = "terraform.tfstate"
    name = "ec2toecsmigration"
    encrypt = true
    use_lockfile = true
  }
}
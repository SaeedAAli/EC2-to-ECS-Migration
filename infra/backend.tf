terraform {
  backend "s3" {
    region       = "eu-west-2"
    key          = "terraform.tfstate"
    encrypt      = true
    use_lockfile = true
    bucket       = "ec2toecsmigration"
  }
}
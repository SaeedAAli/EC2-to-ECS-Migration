terraform {
  backend "s3" {
    region       = "eu-west-2"
    key          = "terraform.tfstate"
    encrypt      = true
    use_lockfile = true
    bucket       = "infra/ec2toecsmigration"
  }
}
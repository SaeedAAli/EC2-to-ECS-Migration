terraform {
  backend "s3" {
    bucket = "ec2toecsmigration"
    key = ".terraform/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
  }
}




resource "aws_s3_bucket" "ec2toecs" {
  bucket = "ec2toecsmigration"
}

resource "aws_s3_bucket_versioning" "ec2toecs_vers" {
  bucket = aws_s3_bucket.ec2toecs.id

  versioning_configuration {
    status = "Enabled"
  }

}

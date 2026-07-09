resource "aws_s3_bucket" "ec2toecs" {
  bucket = "ec2toecsmigration"
}

resource "aws_s3_bucket_versioning" "ec2toecs_vers" {
  bucket = aws_s3_bucket.ec2toecs

  versioning_configuration {
    status = "enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_repository" "EC2_TO_LEGACY" {
name = var.name
image_tag_mutability = "Mutable"

 image_scanning_configuration {
  scan_on_push = true
 }
    tags = {
        Name = "ECS APP"
    }
    }

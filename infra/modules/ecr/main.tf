resource "aws_ecr_repository" "ecr" {
  name                 = "ecs"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "ECS APP"
  }
}

resource "aws_ecr_repository" "ecr" {
  name                 = "ec2toecsdckfile"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "ECS APP"
  }
}

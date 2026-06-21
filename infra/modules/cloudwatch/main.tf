resource "aws_cloudwatch_log_group" "ecs" {
  name              = "Cloudwatch-for-App"
  retention_in_days = 30

  tags = {
    Name = "Group Log"
  }
}

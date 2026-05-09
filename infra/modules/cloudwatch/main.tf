resource "aws_cloudwatch_log_group" "ecs" {
  name = var.cloudwatch
  retention_in_days = var.number

  tags = {
    Name = "Group Log"
  }
}
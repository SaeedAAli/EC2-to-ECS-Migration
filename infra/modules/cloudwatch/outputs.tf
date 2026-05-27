output "log_group" {
  value = aws_cloudwatch_log_group.ecs.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.ecs.name
}


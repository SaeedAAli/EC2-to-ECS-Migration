output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of ECS task execution role"
}

output "ecs_task_execution_role_name" {
  value       = aws_iam_role.ecs_task_execution_role.name
  description = "Name of ECS task execution role"
}
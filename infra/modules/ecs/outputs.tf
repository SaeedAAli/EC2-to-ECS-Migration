output "cluster" {
  value = aws_ecs_cluster.caravan.arn
}

output "task_definiton" {
  value = aws_ecs_task_definition.TK
}

output "Family" {
  value = aws_ecs_task_definition.TK.family
}

output "network_mode" {
  value = aws_ecs_task_definition.TK.network_mode
}

output "cpu" {
  value = aws_ecs_task_definition.TK.cpu
}

output "execution_role" {
  value = aws_ecs_task_definition.TK.execution_role_arn
}


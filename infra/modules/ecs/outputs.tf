output "cluster" {
  value = aws_ecs_cluster.caravan.arn
}

output "task_definiton" {
  value = aws_ecs_task_definition.TK.id
}

output "Family" {
  value = aws_ecs_task_definition.TK.family.id
}

output "network_mode" {
  value = aws_ecs_task_definition.TK.network_mode.id
}

output "cpu" {
  value = aws_ecs_task_definition.TK.cpu.id
}

output "execution_role" {
  value = aws_ecs_task_definition.TK.execution_role_arn.id
}

output "task-role-arn" {
  value = aws_ecs_task
}

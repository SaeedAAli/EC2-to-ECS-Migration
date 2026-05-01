output "ALB_Security_roup" {
  description = "ID For SG ALB"
  value = aws_security_group.Application_Load_Balancer.id
}

output "ECS_TASKS" {
  description = "Tasks for the ECS"
  value = aws_security_group.ECS_TSKS.id
}
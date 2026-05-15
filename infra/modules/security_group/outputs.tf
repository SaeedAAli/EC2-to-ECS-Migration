output "ALB_Security_group" {
  description = "ID For SG ALB"
  value = aws_security_group.Application_Load_Balancer
}

output "ECS_TASKS" {
  description = "Tasks for the ECS"
  value = aws_security_group.ECS_TSKS
}
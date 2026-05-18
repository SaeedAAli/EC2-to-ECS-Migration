output "vpc_id" {
  value = module.vpc.vpc
  description = "vpc_id"
}

output "Application_LB_SG" {
  value = module.security_group.ALB_Security_group
  description = "Application Load Balancer.SG"
}

output "Subnet1_id" {
  value = module.vpc.PublicSubnet1
}

output "Subnet2_id" {
  value = module.vpc.PublicSubnet2
}

output "iam_task" {
  value = module.iam.ecs_task_execution_role_arn
}

output "ecs_name" {
 value = module.iam.ecs_task_execution_role_name
}
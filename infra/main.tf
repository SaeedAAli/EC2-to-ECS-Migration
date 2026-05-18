module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  PublicSubnet1 = var.public_subnet1
  PublicSubnet2 = var.public_subnet2
  PrivateSubnet1 = var.private_subnet1
  PrivateSubnet2 = var.private_subnet2
}

module "security_group" {
  source = "./modules/security_group"
  vpc = module.vpc.vpc
}

module "ECS" {
  source = "./modules/ecs"
  require_compatibilities = var.require_compatibilities
  cpu = var.cpu
  memory = var.memory
  name = var.name
  execution_role = module.iam.ecs_task_execution_role_arn
  family = var.family
  network_mode = var.network_mode
  image = var.image
  task-role-arn = module.iam.ecs_task_execution_role_arn
  alb-target-group = module.ALB.target_type_arn
  IAM = module.iam.ecs_task_execution_role_arn
}


module "ALB" {
  source = "./modules/alb"
  internal = var.internal
  ALBname = var.ALBname
  load_balancer_type = var.load_balancer_type
  subnets = [module.vpc.PublicSubnet1, module.vpc.PublicSubnet2]
  security_groups = [module.security_group.ALB_Security_group.id]
  Target_Port = var.Target_port
  Target_Protocol = var.Target_Protocol
  Target_type = var.Target_type
  Target_group_name = var.Target_group_name
  vpc_id = module.vpc.vpc
}

module "iam" {
  source = "./modules/iam"
    
  }
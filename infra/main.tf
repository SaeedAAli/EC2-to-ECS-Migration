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
  execution_role = var.execution_role_arn
  family = var.family
  network_mode = var.network_mode
  image = var.image
  task-role-arn = var.task-role-arn
}


module "ALB" {
  source = "./modules/alb"
  load_balancer_type = module.security_group.ALB_Security_group
  name = var.ALBname
  subnet1 = module.vpc.PublicSubnet1
  subnet2 = module.vpc.PublicSubnet2
  internal = var.internal
}


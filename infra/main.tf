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
  alb-target-group = module.ALB.target_group_arn
  IAM = module.iam.ecs_task_execution_role_arn
  subnets_ecs = [module.vpc.PrivateSubnet1, module.vpc.PrivateSubnet2]
  ecs_sg = module.security_group.ECS_TASKS
  cloudwatch = module.cloudwatch.log_group
  
}


module "ALB" {
  source = "./modules/alb"
  internal = var.internal
  ALBname = var.ALBname
  load_balancer_type = var.load_balancer_type
  subnets = [module.vpc.PublicSubnet1, module.vpc.PublicSubnet2]
  Target_Port = var.Target_port
  Target_Protocol = var.Target_Protocol
  Target_type = var.Target_type
  Target_group_name = var.Target_group_name
  vpc_id = module.vpc.vpc
  alb_sg = module.security_group.ALB_Security_group
  certification = module.acm.http_cert
}

module "iam" {
  source = "./modules/iam"
    
  }

module "Route53" {
  source = "./modules/route53"
  dns_name = module.ALB.dns_name
  alb_zone_id = module.ALB.zone_id
  subdomain = var.subdomain
}

module "acm" {
  source = "./modules/acm"
  dns_name = module.Route53.subdomain
  zone_id = module.Route53.route53_zone

}


module "ecr" {
  source = "./modules/ecr"
}


module "cloudwatch" {
  source = "./modules/cloudwatch"

}
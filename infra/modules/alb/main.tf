resource "aws_alb" "ALB" {
  name = var.ALBname
  internal = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups = aws_security_group.Application_Load_Balancer
  subnets = [module.vpc.PublicSubnet1, module.vpc.PublicSubnet2]
}

resource "aws_alb_target_group" "TG" {
  name = var.ALBname
  target_type = var.Target_type
  port = var.Target_Port
  protocol = var.Target_Protocol
  vpc_id = var.vpc_id
}
resource "aws_alb" "ALB" {
  name = var.ALBname
  internal = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups = aws_security_group.Application_Load_Balancer
  subnets = [module.vpc.PublicSubnet1, module.vpc.PublicSubnet2]

}
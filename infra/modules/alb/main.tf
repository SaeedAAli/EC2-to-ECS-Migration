resource "aws_alb" "ALB" {
  name = var.name
  internal = var.internal
  load_balancer_type = var.load_balancer_type
  subnets = 
}
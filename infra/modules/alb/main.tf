resource "aws_lb" "ALB" {
  name = var.ALBname
  internal = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups = var.security_groups
  subnets = var.subnets
}

resource "aws_lb_target_group" "TG" {
  name = var.ALBname
  target_type = var.Target_type
  port = var.Target_Port
  protocol = var.Target_Protocol
  vpc_id = var.vpc_id

   health_check {
     healthy_threshold = 2
     unhealthy_threshold = 2
     timeout = 3
     interval = 30
     path = "/"
     matcher = "200"
   }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  default_action {
    target_group_arn = aws_lb_target_group.TG.arn
    type = "forward"
  }
    port = 80
    protocol = "HTTP"
}
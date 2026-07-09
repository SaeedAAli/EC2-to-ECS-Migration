resource "aws_lb" "application_load_balancer" {
  name               = var.ALBname
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets
  security_groups    = [var.alb_sg]
}

resource "aws_lb_target_group" "TG" {
  name        = var.ALBname
  target_type = var.Target_type
  port        = var.Target_Port
  protocol    = var.Target_Protocol
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }

}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  default_action {
    target_group_arn = aws_lb_target_group.TG.arn
    type             = "forward"
  }
  port     = 80
  protocol = "HTTP"
}

resource "aws_lb_listener" "HTTPS" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  certificate_arn   = var.certification
  default_action {
    target_group_arn = aws_lb_target_group.TG.arn
    type             = "forward"
  }
  port     = 443
  protocol = "HTTPS"

  depends_on = [var.certification_validation_for_https]
}


resource "aws_cloudwatch_metric_alarm" "alb_4xx" {
  alarm_name = "terraform-4xx"
  comparison_operator = "GreaterThanThreshold"
  namespace = "AWS/ApplicationELB"
  dimensions = {
    LoadBalancer = aws_lb.application_load_balancer.arn_suffix
  }
  period = 120
  statistic = "Sum"
  metric_name = "HTTPCode_ELB_4XX_Count"
  threshold = 80
  evaluation_periods = 2

}



resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name = "terraform-5xx"
  comparison_operator = "GreaterThanThreshold"
  namespace = "AWS/ApplicationELB"
  dimensions = {
    LoadBalancer = aws_lb.application_load_balancer.arn_suffix
  }
  period = 60
  statistic = "Sum"
  metric_name = "HTTPCode_ELB_5XX_Count"
  threshold = 20
  evaluation_periods = 2

}





resource "aws_cloudwatch_metric_alarm" "CPU" {
  metric_name = "CPU"
  alarm_name = "High5XXAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace = "AWS/ApplicationELB"
  statistic = "Sum"
  threshold = 60
  evaluation_periods = 2
  period = 120
  dimensions = {
    LoadBalancer = aws_lb.application_load_balancer.arn_suffix

  }

  tags = {
    Name = "Measure High 5XX"
  }

}


output "name" {
  value = aws_lb.application_load_balancer.name
}

output "load_balancer_type" {
  value = aws_lb.application_load_balancer.load_balancer_type
}




# ---
# Target Group Values

output "port" {
  value = aws_lb_target_group.TG.port
}

output "protocol" {
  value = aws_lb_target_group.TG.protocol
}

output "target_type" {
  value = aws_lb_target_group.TG.target_type
}

output "Target_group_name" {
  value = aws_lb_target_group.TG.id
}

output "vpc_id" {
  value = aws_lb_target_group.TG.vpc_id
}

output "target_group_arn" {
  value = aws_lb_target_group.TG.arn
}
# -----------------
#Listener
output "Listener" {
  value = aws_lb_listener.lb_listener.arn
}
output "Load_Balancer_ARN" {
  value = aws_lb_listener.lb_listener.load_balancer_arn
}


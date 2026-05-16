output "name" {
  value = aws_alb.ALB.name
}

output "load_balancer_type" {
  value = aws_alb.ALB.load_balancer_type
}

output "internal" {
  value = aws_alb.Internal
}

# ---
# Target Group Values

output "port" {
  value = aws_alb_target_group.TG.port
}

output "protocol" {
  value = aws_alb_target_group.TG.protocol
}

output "target_type" {
  value = aws_alb_target_group.TG.target_type
}

output "Target_group_name" {
  value = aws_alb_target_group.TG.name
}

output "vpc_id" {
  value = aws_alb_target_group.TG.vpc_id
}
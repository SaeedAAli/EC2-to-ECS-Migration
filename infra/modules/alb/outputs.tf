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
#
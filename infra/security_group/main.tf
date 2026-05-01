resource "aws_security_group" "Application_Load_Balancer" {
  name = "alb_sg"
  vpc_id = var.vpc


ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ECS_TSKS" {
  name = "ecs_tasks_sg"
  vpc_id = var.vpc

  ingress {
    from_port = 5002
    to_port = 5002
    protocol = "tcp"
    security_groups = [aws_security_group.Application_Load_Balancer.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
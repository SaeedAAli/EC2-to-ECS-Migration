resource "aws_ecs_cluster" "caravan" {
  name = "cluster"
}

resource "aws_ecs_task_definition" "TK" {
  family = "caravan_task"
  container_definitions = jsonencode([
    {
      name = var.name
      family = var.family
      image = var.image
      cpu = var.cpu
      require_compatibilites = var.require_compatibilities
      network_mode = var.network_mode
      execution-role = var.execution_role
      portMappings = [{
        containerPort = 5002
        hostPort = 5002
        protocol = "tcp"
      }
      ]
    
    
    }
  ])
}

resource "aws_ecs_service" "ecs-service" {
  name = "ecs-service"
  cluster = aws_ecs_cluster.caravan.id
  task_definition = aws_ecs_task_definition.TK.arn
  desired_count = 3

    load_balancer {
      target_group_arn = var.alb-target-group
      container_name = "ecs"
      container_port = "5002"
    }

}

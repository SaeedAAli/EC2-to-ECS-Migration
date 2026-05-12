resource "aws_ecs_cluster" "caravan" {
  name = "cluster"
}

resource "aws_ecs_task_definition" "TK" {
  family = "caravan_task"
  container_definitions = jsonencode([
    {
      name = var.name
      family = var.family
      Image = var.image
      cPU = var.cpu
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
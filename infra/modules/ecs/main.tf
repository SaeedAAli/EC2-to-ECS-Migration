resource "aws_ecs_cluster" "caravan" {
  name = var.name
}

resource "aws_ecs_task_definition" "TK" {
  family                   = "caravan_task"
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = var.network_mode
  requires_compatibilities = var.require_compatibilities
  execution_role_arn       = var.execution_role
  task_role_arn            = var.task_role_arn

  runtime_platform {
    cpu_architecture        = "ARM64"
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode([
    {
      name   = var.name
      image  = var.image
      cpu    = 256
      memory = 512
      portMappings = [
        {
          containerPort = 5002
          hostPort      = 5002
          protocol      = "tcp"
        }

      ]
      "logConfiguration" = {
        logDriver = "awslogs"
        "options" = {
          "awslogs-group"         = var.cloudwatch
          "awslogs-stream-prefix" = "ecs"
          "awslogs-region"        = "eu-west-2"
        }
      }
    }



  ])


}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.caravan.id
  task_definition = aws_ecs_task_definition.TK.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.alb_target_group
    container_name   = var.name
    container_port   = 5002
  }

  network_configuration {
    subnets          = var.subnets_ecs
    assign_public_ip = false
    security_groups  = [var.ecs_sg]
  }

}


resource "aws_appautoscaling_target" "ecs_target" {
  min_capacity       = 2
  max_capacity       = 6
  resource_id        = "service/${aws_ecs_cluster.caravan.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "target-track"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 70.0
    disable_scale_in   = false
    scale_in_cooldown  = 300
    scale_out_cooldown = 60

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

  }
}


resource "aws_cloudwatch_log_group" "ecs" {
  name = var.cloudwatch

} 



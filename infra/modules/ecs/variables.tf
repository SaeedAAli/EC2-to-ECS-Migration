variable "name" {
  type = string
  description = "name of the cluster"
}

variable "family" {
  type = string
  description = "value"
}

variable "network_mode" {
  type = string
  description = "aws-vpc"
}

variable "require_compatibilities" {
  type = list(string)
  description = "Set Launch for Fargate Serverless"
}

variable "cpu" {
  type = string
  description = "cpu cores"

}

variable "memory" {
  type = string
  description = "How much RAM is being used"
}

variable "execution_role" {
  type = string
  description = "Specifically for IAM ECS Roles"
}

variable "image" {
  type = string
  description = "Docekr Image"
  
}

variable "task-role-arn" {
  type = string
  description = "Task role arn"
}

variable "alb-target-group" {
  type = string
}

variable "IAM" {
  type = string
}

variable "subnets_ecs" {
  type = list(string)
}

variable "ecs_sg" {
  type = string
}


variable "cloudwatch" {
  type = string
}
variable "name" {
  type = string
  description = "Name of the Application Load Balancer"
}

variable "load_balancer_type" {
  type = string
  description = "Type of Load Balancer which is application"
}

variable "subnet1" {
  type = string
  description = "Subnet one for one application load balancer"
}

variable "subnet2" {
  type = string
  description = "Subnet two for one application load balancer"
}

variable "security_groups" {
  type = string
  description = "Filters out for 5002 Port for ECS"
}

variable "internal" {
  type = string
  description = "If true, LB will be internal defaults to false"
}
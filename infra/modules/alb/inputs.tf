variable "ALBname" {
  type = string
  description = "Name of the Application Load Balancer"
}

variable "load_balancer_type" {
  type = string
  description = "Type of Load Balancer which is application"
}

variable "internal" {
  type = string
  description = "If true, LB will be internal defaults to false"
}

variable "subnets" {
  type = string
  description = "Both Public Subnets"
}

variable "security_groups" {
  type = string
  description = "SG for ALB"
}
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

# -------------
# Target Group

variable "Target_type" {
  description = "string"
  type = string
}

variable "Target_Protocol" {
  type = string
  description = "TCP"
}

variable "Target_Port" {
  type = number
  description = "Route to TG"
}

variable "Target_type" {
  type = string
  description = "alb"
}
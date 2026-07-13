## Virtual Private Cloud

variable "vpc_cidr" {
  type        = string
  description = "cidr block"
}

variable "public_subnet1" {
  type        = string
  description = "Public Subnet 1 CIDR"
}

variable "public_subnet2" {
  type        = string
  description = "Public Subnet 2 CIDR"
}

variable "private_subnet1" {
  type        = string
  description = "Private Subnet 1 CIDR"
}

variable "private_subnet2" {
  type        = string
  description = "Private Subnet 2 CIDR"
}

#------------------------------------------
# Elastic Container Service


variable "family" {
  type        = string
  description = "Name of the Application"
}


variable "cpu" {
  type        = string
  description = "Amount of Cores within TK"
}

variable "image" {
  type        = string
  description = "Docker Image"
}

variable "network_mode" {
  type        = string
  description = "Which VPC will it be connected to"

}

variable "require_compatibilities" {
  type        = list(string)
  description = "Fargate Serverless"
}

variable "memory" {
  type        = string
  description = "RAM Usage"
}


variable "name" {
  type        = string
  description = "Name of Cluster"
}



#--------------------------------
# Application Load Balancer

variable "ALBname" {
  type        = string
  description = "Name of the Load Balancer"
}

variable "internal" {
  type        = bool
  description = "If false it will work"
}

variable "load_balancer_type" {
  type        = string
  description = "Type of Load Balancer - ALB or CLB or NLB"

}

#------------
# ALB Target Group

variable "Target_group_name" {
  type        = string
  description = "Name of the Target Group"
}

variable "Target_type" {
  type        = string
  description = "Which Load Balancer, This instance, ALB"
}

variable "Target_port" {
  type        = number
  description = "Port 80 == HTTP"
}

variable "Target_Protocol" {
  type        = string
  description = "Tranmission Control Protocol"
}


# ------
#Route53 Records

variable "subdomain" {
  type        = string
  description = ".."
}



# --------
# Cloudflare DNS
variable "zone_id" {
  type = string
}

# --------
# Weighted Routing (Cutover)
variable "ec2_eip" {
  type        = string
  description = "Elastic IP of the legacy EC2 instance for weighted routing"
}

variable "ecs_weight" {
  type        = number
  description = "Route53 weighted routing weight for ECS target (sum of both weights should equal 100)"
}

variable "ec2_weight" {
  type        = number
  description = "Route53 weighted routing weight for EC2 legacy instance"
}

variable "ttl" {
  type        = number
  description = "TTL for Route53 records (low = faster cutover propagation)"

}


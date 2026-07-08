variable "subdomain" {
  type = string
  description = "domain for ec2toecsmigration"
}

variable "alb_zone_id" {
  type = string
  description = "Route53 Alias Record"
}

variable "dns_name" {
  type = string
  description = "dns name of load balancer"
}

# -------------------------------------
#Cloudflare DNS record



variable "zone" {
  type = string
}

variable "ec2_eip" {
  type        = string
  description = "Elastic IP of the legacy EC2 instance for weighted routing"
  default     = ""
}

variable "ecs_weight" {
  type        = number
  description = "Weight for ECS target group"
  default     = 100
}

variable "ec2_weight" {
  type        = number
  description = "Weight for EC2 legacy instance"
  default     = 0
}

variable "ttl" {
  type        = number
  description = "TTL for EC2 A-record (low for fast cutover)"
  default     = 60
}
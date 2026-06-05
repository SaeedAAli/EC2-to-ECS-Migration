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


terraform {
  required_providers {
    cloudflare =  {
      source = "cloudflare/cloudflare"
    }
  }
}





resource "aws_route53_zone" "subdomain_zone" {
  name = var.subdomain
}


resource "aws_route53_record" "ecs" {
  zone_id = aws_route53_zone.subdomain_zone.zone_id
  name    = var.subdomain
  type    = "A"
  set_identifier = "ecs"
  weighted_routing_policy {
    weight = var.ecs_weight
  }
  alias {
    name                   = var.dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ec2" {
  count   = var.ec2_eip != "" ? 1 : 0
  zone_id = aws_route53_zone.subdomain_zone.zone_id
  name    = var.subdomain
  type    = "A"
  set_identifier = "ec2"
  weighted_routing_policy {
    weight = var.ec2_weight
  }
  records = [var.ec2_eip]
  ttl     = var.ttl
}



resource "aws_route53_health_check" "HTTP" {
  request_interval = "30"
  type = "HTTP"
  resource_path = "/health"
  failure_threshold = "3"
  fqdn = var.subdomain
}


resource "aws_route53_health_check" "HTTPS" {
  request_interval = "30"
  type = "HTTPS"
  resource_path = "/health"
  failure_threshold = "3"
  fqdn = var.subdomain
}

resource "cloudflare_dns_record" "name" {
  count = 4
  name = var.subdomain
  type = "NS"
  ttl = 3600
  zone_id = var.zone
  content = aws_route53_zone.subdomain_zone[count.index]

}
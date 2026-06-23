
resource "aws_route53_zone" "subdomain_zone" {
  name = var.subdomain
}


resource "aws_route53_record" "ec2toECS" {
  name = var.subdomain
  zone_id = aws_route53_zone.subdomain_zone.zone_id
  type = "A"
  alias {
    name = var.dns_name 
    zone_id = var.alb_zone_id
    evaluate_target_health = true
  }

 }



resource "aws_route53_health_check" "HTTP" {
  request_interval = "30"
  type = "HTTP"
  resource_path = "/ec2-ecs/health"
  failure_threshold = "3"
  fqdn = var.subdomain
}


resource "aws_route53_health_check" "HTTPS" {
  request_interval = "30"
  type = "HTTPS"
  resource_path = "/ec2-ecs/health"
  failure_threshold = "3"
  fqdn = var.subdomain
}



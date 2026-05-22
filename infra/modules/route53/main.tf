resource "aws_route53_zone" "public_zone" {
  name = "saeedaali.uk"
}

resource "aws_route53_record" "ec2toECS" {
  name = var.subdomain
  zone_id = aws_route53_zone.public_zone.zone_id
  type = "A"
  alias {
    name = var.dns_name 
    zone_id = var.alb_zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "Root" {
  name = "saeedaali.uk"
  zone_id = aws_route53_zone.public_zone.zone_id
  type = "A"
  alias {
    name = var.dns_name
    zone_id = var.alb_zone_id
    evaluate_target_health = true
  }
}



resource "aws_route53_health_check" "name" {
  request_interval = "30"
  type = "Https"
  
}
output "route53_zone" {
    value = aws_route53_zone.subdomain_zone.zone_id
}

output "subdomain" {
  value = aws_route53_record.ecs.name
}

output "HTTP" {
  value = aws_route53_health_check.HTTP.type
}

output "HTTPS" {
  value = aws_route53_health_check.HTTPS.type
}




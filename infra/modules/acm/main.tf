resource "aws_acm_certificate" "cert" {
  domain_name = var.dns_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "certification" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name =>{
      name = dvo.resource_record_name
      type = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name = each.value.name
  records = [each.value.value]
  ttl = 60
  type = each.value.type
}

resource "aws_acm_certificate_validation" "valid" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.certification: record.fqdn]

}
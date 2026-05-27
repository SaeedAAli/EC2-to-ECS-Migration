resource "aws_acm_certificate" "cert" {
  domain_name = var.dns_name
  validation_method = "DNS"
}







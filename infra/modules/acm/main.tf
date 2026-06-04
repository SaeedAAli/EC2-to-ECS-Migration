resource "aws_acm_certificate" "cert" {
  domain_name = var.dns_name
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "valid" {
  certificate_arn = aws_acm_certificate.cert.arn

}






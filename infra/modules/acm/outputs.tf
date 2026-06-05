output "http_cert" {
  value = aws_acm_certificate.cert.arn
}

output "domain_valid_options" {
  value = aws_acm_certificate.cert.domain_validation_options
}

output "cerification_validation" {
  value = aws_acm_certificate_validation.valid.id
}
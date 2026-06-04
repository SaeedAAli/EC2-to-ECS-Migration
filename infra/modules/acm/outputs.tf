output "http_cert" {
  value = aws_acm_certificate.cert.arn
}

output "validation" {
  value = aws_acm_certificate_validation.valid.id
}
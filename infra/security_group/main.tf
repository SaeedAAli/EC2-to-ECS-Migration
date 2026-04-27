resource "aws_security_group" "SG" {
  vpc_id = aws_vpc.main
}
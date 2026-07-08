data "aws_eip" "legacy" {
  count = var.ec2_eip == "" ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["legacy-api-eip"]
  }
}

locals {
  ec2_eip = var.ec2_eip != "" ? var.ec2_eip : try(data.aws_eip.legacy[0].public_ip, "")
}

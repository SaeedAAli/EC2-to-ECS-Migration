variable "EcsVpc" {
  description = "Cidr Block for VPC"
  default = "10.0.0.0/16"
  type = string
}

variable "PublicSubnet1" {
  type = string
  description = " Public Subnet for AZ"
  default = "10.0.1.0/24"
}

variable "PublicSubnet2" {
  type = string
  description = "Public Subnet for AZ"
  default = "10.0.3.0/24"
}

variable "PrivateSubnet1" {
  type = string
  description = "Private Subnet for AZ"
  default = "10.0.4.0/24"
}

variable "PrivateSubnet2" {
type = string
description = "Private Subnet for AZ"
default = "10.0.2.0/24"
}

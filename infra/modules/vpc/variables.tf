variable "vpc_cidr" {
  description = "Cidr Block for VPC"
  type = string
}

variable "PublicSubnet1" {
  type = string
  description = " Public Subnet for AZ"
}

variable "PublicSubnet2" {
  type = string
  description = "Public Subnet for AZ"
}

variable "PrivateSubnet1" {
  type = string
  description = "Private Subnet for AZ"
}

variable "PrivateSubnet2" {
  type = string
  description = "Private Subnet for AZ"
}





variable "vpc_cidr" {
  type = string
  description = "cidr block"
}

variable "public_subnet1" {
  type = string
  description = "Public Subnet 1 CIDR"
}

variable "public_subnet2" {
  type = string
  description = "Public Subnet 2 CIDR"
}

variable "private_subnet1" {
  type = string
  description = "Private Subnet 1 CIDR"
}

variable "private_subnet2" {
  type = string
  description = "Private Subnet 2 CIDR"
}
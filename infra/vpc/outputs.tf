output "PublicSubnets1" {
  value = aws_subnet.Public_Subnet_1.id
  description = "Public Subnet 1 Output"
}

output "PublicSubnet2" {
  value = aws.subnet.Public_Subnet_2.id
  description = "Public Subnet 2 Output"
}

output "PrivateSubnet1" {
  value = aws_subnet.Private_Subnet_1.id
  description = "Private Subnet 1 Output"
}

output "PrivateSubnet2" {
  value = aws_subnet.Private_Subnet_2.id
  description = "Private Subnet 2 Output"
}

output "InternetGW" {
  value = aws_internet_gateway.IGW.id
  description = "IGW"
}

output "vpc" {
  value = aws_vpc.ecs.id
  description = "vpc for ecs"

}

output "Route Table PBLC" {
    value = aws_route_table.public.id
    description = "Route Table Public"
}

output "Route Table PRVTE" {
  value = aws_route_table.private.id
  description = "route table private"
}
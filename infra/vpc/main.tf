resource "aws_vpc" "VpcECS" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  
    tags = {
    Name = "Vpc"
  }
}



resource "aws_subnet" "publicSubnet1"{
vpc_id = aws_vpc.VpcECS.id
cidr_block = "10.0.1.0/24"
availability_zone = "eu-west-1a"
tags  = {
  Name = "Public Subnet"
}
}

resource "aws_subnet" "privateSubnet1" {
  vpc_id = aws_vpc.VpcECS.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "Private Subnet on west 2a"
  }
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id = aws_vpc.VpcECS.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "Public Subnet on west 2a"
  }
}

resource "aws_subnet" "PrivateSubnet2" {
  vpc_id = aws_vpc.VpcECS.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "Private Subnet on AZ 2a"
  }
}

resource "aws_internet_gateway" "ForPublicSubnet" {
  vpc_id = aws_vpc.VpcECS.id
  tags = {
    Name = "igw-ecs"
  }
}



resource "aws_route" "public_igw" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ForPublicSubnet.id
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.VpcECS.id
}

resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.publicSubnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.public.id
  
}


resource "aws_security_group" "VPCSG" {
  description = "Security Group for VPC"
  vpc_id = aws_vpc.VpcECS.id

  ingress = {
    from_port = 
    ip_protocol = 
    to_port = 
  }
}
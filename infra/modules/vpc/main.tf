resource "aws_vpc" "ecs" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Vpc For ECS"
    }
  }


resource "aws_subnet" "Public_Subnet_1" {
  vpc_id = aws_vpc.ecs.id
  cidr_block = var.PublicSubnet1
  availability_zone = "eu-west-1a"
    tags = {
      Name = "Public Subnet"
    }

}

resource "aws_subnet" "Public_Subnet_2" {
  vpc_id = aws_vpc.ecs.id
  cidr_block = var.PublicSubnet2
  availability_zone = "eu-west-2a"
}

resource "aws_subnet" "Private_Subnet_1" {
  vpc_id = aws_vpc.ecs.id
  cidr_block = var.PrivateSubnet1
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "Private_Subnet_2" {
  vpc_id = aws_vpc.ecs.id
  cidr_block = var.PrivateSubnet2
  availability_zone = "eu-west-2a"
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.ecs.id
  tags = {
    Name = "Allow access to the Internet Inside the VPC"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ecs.id
  tags = {
    Name = "PR Table"
}
}

resource "aws_route" "r" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGW.id
}

resource "aws_route_table_association" "Public_Subnet_1" {
  subnet_id = aws_subnet.Public_Subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "Public_Subnet_2" {
  subnet_id = aws_subnet.Public_Subnet_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ecs.id
  tags = {
    Name = "PRV Table"
  }  
}

resource "aws_route_table_association" "Private_Subnet_1" {
subnet_id = aws_subnet.Private_Subnet_1.id
route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "Private_Subnet_2" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.Private_Subnet_2.id
}
  

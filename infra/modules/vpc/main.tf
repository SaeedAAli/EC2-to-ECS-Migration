resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Vpc For ECS"
  }
}


resource "aws_subnet" "Public_Subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PublicSubnet1
  availability_zone = "eu-west-2a"
  tags = {
    Name = "Public Subnet"
  }

}

resource "aws_subnet" "Public_Subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PublicSubnet2
  availability_zone = "eu-west-2b"
}

resource "aws_subnet" "Private_Subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PrivateSubnet1
  availability_zone = "eu-west-2a"
}

resource "aws_subnet" "Private_Subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PrivateSubnet2
  availability_zone = "eu-west-2b"
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Allow access to the Internet Inside the VPC"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "PR Table"
  }
}

resource "aws_route" "r" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

resource "aws_route" "Nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NATGW_PB1.id
}

resource "aws_route_table_association" "Public_Subnet_1" {
  subnet_id      = aws_subnet.Public_Subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "Public_Subnet_2" {
  subnet_id      = aws_subnet.Public_Subnet_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "PRV Table"
  }
}

resource "aws_route_table_association" "Private_Subnet_1" {
  subnet_id      = aws_subnet.Private_Subnet_1.id
  route_table_id = aws_route_table.private.id

}

resource "aws_route_table_association" "Private_Subnet_2" {
  route_table_id = aws_route_table.private2.id
  subnet_id      = aws_subnet.Private_Subnet_2.id
}

resource "aws_nat_gateway" "NATGW_PB1" {
  subnet_id     = aws_subnet.Public_Subnet_1.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "NGW"
  }
}



resource "aws_eip" "eip" {
  domain = "vpc"

}



resource "aws_nat_gateway" "NATGW_PB2" {
  subnet_id     = aws_subnet.Public_Subnet_2.id
  allocation_id = aws_eip.elastic_ip_2.id

  tags = {
    Name = "Nat Gateway 2"
  }
}


resource "aws_eip" "elastic_ip_2" {
  domain = "vpc"
}

resource "aws_route" "Nat_Route2" {
  nat_gateway_id         = aws_nat_gateway.NATGW_PB2.id
  route_table_id         = aws_route_table.private2.id
  destination_cidr_block = "0.0.0.0/0"

}


resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Solely for Adding in another Nat Gateway in Public Subnet for High Avaliability"
  }
}
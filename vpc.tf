# VPC
resource "aws_vpc" "pearlfurniture-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "fyp-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.pearlfurniture-vpc.id

  tags = {
    Name = "fyp-igw"
  }
}

# Public Subnet AZ1
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.pearlfurniture-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-az1"
  }
}

# Public Subnet AZ2
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.pearlfurniture-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-az2"
  }
}

# Private Subnet AZ1
resource "aws_subnet" "private_az1" {
  vpc_id            = aws_vpc.pearlfurniture-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-az1"
  }
}

# Private Subnet AZ2
resource "aws_subnet" "private_az2" {
  vpc_id            = aws_vpc.pearlfurniture-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-az2"
  }
}

# Elastic IP for NAT Gateway AZ1
resource "aws_eip" "nat_eip_az1" {
  domain = "vpc"
}

# NAT Gateway AZ1
resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id     = aws_subnet.public_az1.id

  tags = {
    Name = "nat-gw-az1"
  }
}

# Elastic IP for NAT Gateway AZ2
resource "aws_eip" "nat_eip_az2" {
  domain = "vpc"
}

# NAT Gateway AZ2
resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id     = aws_subnet.public_az2.id

  tags = {
    Name = "nat-gw-az2"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.pearlfurniture-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Associate Public Subnets to Public Route Table
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table AZ1
resource "aws_route_table" "private_az1" {
  vpc_id = aws_vpc.pearlfurniture-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
  }

  tags = {
    Name = "private-rt-az1"
  }
}

# Private Route Table AZ2
resource "aws_route_table" "private_az2" {
  vpc_id = aws_vpc.pearlfurniture-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_az2.id
  }

  tags = {
    Name = "private-rt-az2"
  }
}

# Associate Private Subnets to Private Route Tables
resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_az1.id
}

resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_az2.id
}
 
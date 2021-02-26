resource "aws_vpc" "jmm-aws-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name       = "jmm-aws-vpc"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_internet_gateway" "jmm_internet_gateway" {
  vpc_id = aws_vpc.jmm-aws-vpc.id

  tags = {
    Name       = "jmm_internet_gateway"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

//FIXME: NAT instance for private to internet traffic

/*
  Public Subnet
*/

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.jmm-aws-vpc.id

  cidr_block        = var.public_subnet_cidr
  availability_zone = var.aws_availability_zone

  tags = {
    Name       = "Jmm Public Subnet"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.jmm-aws-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jmm_internet_gateway.id
  }

  tags = {
    Name       = "Jmm Public Subnet"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet.id
}
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

/*
  NAT instance for private to internet traffic
*/
resource "aws_security_group" "nat" {
  name        = "Jmm vpc_nat"
  description = "Allow traffic to pass from the private subnet to the internet"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet_cidr]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet_cidr]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.jmm-aws-vpc.id

  tags = {
    Name       = "Jmm_NATSG"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name       = "Jmm NAT eip"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_nat_gateway" "nat_gtw" {

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name       = "Jmm VPC NAT"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}


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

/*
  Private Subnet
*/
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.jmm-aws-vpc.id

  cidr_block        = var.private_subnet_cidr
  availability_zone = var.aws_availability_zone

  tags = {
    Name       = "Jmm Private Subnet"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

//define the route table and configure it so that all machines in the private 
//subnet can reach the Internet via the Gateway
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.jmm-aws-vpc.id

  tags = {
    Name       = "Jmm Private Subnet route table"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gtw.id
}

resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route_table.id
}


# aws_route53_zone.internal:
resource "aws_route53_zone" "internal" {
  comment = "internal zone for cloudbees cluster"
  name    = var.internal_domain_name
  tags = {
    "Name"     = var.internal_domain_name
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
  vpc {
    vpc_id     = aws_vpc.jmm-aws-vpc.id
    vpc_region = var.aws_region
  }
}
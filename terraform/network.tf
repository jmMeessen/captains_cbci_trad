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
  name        = "vpc_nat"
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

resource "aws_instance" "nat" {
  ami                         = "ami-30913f47" # this is a special ami preconfigured to do NAT
  availability_zone           = var.aws_availability_zone
  instance_type               = "m1.small"
  key_name                    = aws_key_pair.my-aws-key.key_name
  vpc_security_group_ids      = [aws_security_group.nat.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name       = "Jmm VPC NAT"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_eip" "nat" {
  instance = aws_instance.nat.id
  vpc      = true
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
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.jmm-aws-vpc.id

  cidr_block        = var.private_subnet_cidr
  availability_zone = var.aws_availability_zone

  tags = {
    Name       = "Private Subnet"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_route_table" "private-subnet" {
  vpc_id = aws_vpc.jmm-aws-vpc.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat.id
  }

  tags = {
    Name       = "Private Subnet"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_route_table_association" "private-subnet" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-subnet.id
}
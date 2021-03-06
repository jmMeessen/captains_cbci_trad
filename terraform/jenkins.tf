/*
  Database Servers
*/
resource "aws_security_group" "sg-jenkins" {

  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr]
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

  vpc_id = aws_vpc.jmm-aws-vpc.id

  tags = {
    Name       = "jenkinsSG"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = var.aws_availability_zone
  instance_type          = "m1.medium"
  key_name               = aws_key_pair.my-aws-key.key_name
  vpc_security_group_ids = [aws_security_group.sg-jenkins.id]
  subnet_id              = aws_subnet.private_subnet.id
  source_dest_check      = false

  tags = {
    Name       = "Jenkins server"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}
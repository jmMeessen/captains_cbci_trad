/*
  Docker Agent
*/
resource "aws_security_group" "docker_agent_sg" {

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
    Name       = "docker_agent_SG"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}
resource "aws_security_group" "ldap_sg" {
  name = "JMM_LDAP_sg"

  #LDAP port
  egress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  vpc_id = aws_vpc.jmm-aws-vpc.id

  tags = {
    Name       = "ldapSG"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_instance" "docker_agent" {
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = var.aws_availability_zone
  instance_type          = "m1.medium"
  key_name               = aws_key_pair.my-aws-key.key_name
  vpc_security_group_ids = [aws_security_group.docker_agent_sg.id, aws_security_group.ldap_sg.id, ]
  subnet_id              = aws_subnet.private_subnet.id
  source_dest_check      = false

  tags = {
    Name       = "Docker agent"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}
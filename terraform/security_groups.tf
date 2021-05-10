resource "aws_security_group" "agent_sg" {

  description = "Base security for Agents (incoming SSH and Ping, and outgoing HTTP/S)"

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
    Name       = "Jmm_default_agent_SG"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_security_group" "ldap_sg" {
  name = "JMM_LDAP_sg"

  description = "in & out on LDAP default port"

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
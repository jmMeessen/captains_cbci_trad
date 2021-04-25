/*
  Web Servers
*/
resource "aws_security_group" "bastion_sg" {
  name        = "jmm_vpc_bastion"
  description = "Allow incoming HTTP connections."

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.my_public_ip_json.ip}/32"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${local.my_public_ip_json.ip}/32"]
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
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = var.aws_availability_zone
  instance_type          = "m1.small"
  key_name               = aws_key_pair.my-aws-key.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = aws_subnet.public_subnet.id
  source_dest_check      = false

  tags = {
    Name       = "Bastion"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc      = true
}
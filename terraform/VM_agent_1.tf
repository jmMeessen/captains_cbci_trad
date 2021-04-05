/*
  Agent_1
*/


resource "aws_instance" "agent1" {
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = var.aws_availability_zone
  instance_type          = "m1.medium"
  key_name               = aws_key_pair.my-aws-key.key_name
  vpc_security_group_ids = [aws_security_group.agent_sg.id, ]
  subnet_id              = aws_subnet.private_subnet.id
  source_dest_check      = false

  tags = {
    Name       = "Agent1"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_route53_record" "agent1" {
  zone_id = aws_route53_zone.internal.id
  name    = "agent1.${var.internal_domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_instance.agent1.private_dns]
}
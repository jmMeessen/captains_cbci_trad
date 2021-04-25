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

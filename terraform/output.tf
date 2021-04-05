output "bastion_ip" {
  value = aws_eip.bastion.public_ip
}

output "cjoc_ip" {
  value = aws_instance.cjoc.private_ip
}

output "cm1_ip" {
  value = aws_instance.cm1.private_ip
}

output "docker_agent_ip" {
  value = aws_instance.docker_agent.private_ip
}

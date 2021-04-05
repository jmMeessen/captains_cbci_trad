output "bastion_ip" {
  value = aws_eip.bastion.public_ip
}

output "bastion_dns" {
  value = aws_eip.bastion.public_dns
}

output "cjoc_ip" {
  value = aws_instance.cjoc.private_ip
}

output "cjoc_dns" {
  value = aws_instance.cjoc.private_dns
}

output "docker_agent_ip" {
  value = aws_instance.docker_agent.private_ip
}

output "docker_agent_dns" {
  value = aws_instance.docker_agent.private_dns
}
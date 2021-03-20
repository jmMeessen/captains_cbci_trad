output "bastion_ip" {
  value = aws_eip.bastion.public_ip
}

output "bastion_dns" {
  value = aws_eip.bastion.public_dns
}

output "jenkins_ip" {
  value = aws_instance.jenkins.private_ip
}

output "jenkins_dns" {
  value = aws_instance.jenkins.private_dns
}

output "docker_agent_ip" {
  value = aws_instance.docker_agent.private_ip
}

output "docker_agent_dns" {
  value = aws_instance.docker_agent.private_dns
}
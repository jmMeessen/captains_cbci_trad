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
output "bastion_ip" {
  value = aws_eip.bastion.public_ip
}

output "bastion_dns" {
  value = aws_eip.bastion.public_dns
}
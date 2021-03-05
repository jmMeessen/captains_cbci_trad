resource "local_file" "ssh_config" {
  content  = templatefile("ssh-config.tpl", { the_bastion_ip = aws_eip.bastion.public_ip })
  filename = "ssh_config"
}

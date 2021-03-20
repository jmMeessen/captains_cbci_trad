resource "local_file" "ssh_config" {
  content = templatefile(
    "ssh-config.tpl",
    {
      the_bastion_ip      = aws_eip.bastion.public_ip,
      the_jenkins_ip      = aws_instance.jenkins.private_ip
      the_docker_agent_ip = aws_instance.docker_agent.private_ip
    }
  )
  filename = "../work_data/ssh_config"
}

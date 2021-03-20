Host bastion
    HostName ${the_bastion_ip}
    User ubuntu
    IdentityFile ~/.ssh/captains_cbci_trad
    StrictHostKeyChecking no
    UserKnownHostsFile ~/work/captains_cbci_trad/work_data/hostfile

Host jenkins
    HostName ${the_jenkins_ip}
    IdentityFile ~/.ssh/captains_cbci_trad
    User ubuntu 
    ProxyJump bastion
    StrictHostKeyChecking no
    UserKnownHostsFile ~/work/captains_cbci_trad/work_data/hostfile

Host docker_agent
    HostName ${the_docker_agent_ip}
    IdentityFile ~/.ssh/captains_cbci_trad
    User ubuntu 
    ProxyJump bastion
    StrictHostKeyChecking no
    UserKnownHostsFile ~/work/captains_cbci_trad/work_data/hostfile
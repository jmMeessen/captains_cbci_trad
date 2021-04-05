Host bastion
    HostName ${the_bastion_ip}
    User ubuntu
    IdentityFile ~/.ssh/captains_cbci_trad
    StrictHostKeyChecking no
    UserKnownHostsFile ~/work/captains_cbci_trad/work_data/hostfile

Host cjoc
    HostName ${the_cjoc_ip}
    IdentityFile ~/.ssh/captains_cbci_trad
    User ubuntu 
    ProxyJump bastion
    StrictHostKeyChecking no
    UserKnownHostsFile ~/work/captains_cbci_trad/work_data/hostfile

Host cm1
    HostName ${the_cm1_ip}
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
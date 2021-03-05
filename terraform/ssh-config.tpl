Host bastion
    HostName ${the_bastion_ip}
    User ubuntu
    IdentityFile ~/.ssh/captains_cbci_trad
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
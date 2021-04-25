# Reference articles

* https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html
* [OpenSSH/Cookbook/Proxies and Jump Hosts](https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts)
* [How to use SSH to proxy through a Linux jump host](https://www.techrepublic.com/article/how-to-use-ssh-to-proxy-through-a-linux-jump-host/)
* [AWS VPC with Public and Private Subnets - Komarov](https://github.com/yurymkomarov/terraform-aws-vpc-public-private)
* [Damien's network training](https://dduportal.github.io/isl-reseau-2018/#/introduction_au_rseau)
* [Getting my own Public IP : Terraform](https://www.reddit.com/r/Terraform/comments/9g62ox/getting_my_own_public_ip/)
* [Terraform: AWS VPC with Private and Public Subnets — Nick Charlton](https://nickcharlton.net/posts/terraform-aws-vpc.html)
* [Running Ansible through SSH Jump / Bastion Host – techbeatly (Jul 2020)](https://www.techbeatly.com/2020/07/running-ansible-through-ssh-jump-bastion-host.html#.YDoHMGPTVpQ)
* [Using Ansible through a Bastion Host (Mar 2020)](https://blog.networktocode.com/post/ansible-bastion-host/)
* [Using Ansible with a jump host (Dec 2019)](https://leftasexercise.com/2019/12/23/using-ansible-with-a-jump-host/)
* [Provisioning a Network Load Balancer with Terraform (Nov 2020)](https://hceris.com/provisioning-a-network-load-balancer-with-terraform/)

## Ansible Jump servers
* https://www.techbeatly.com/2020/07/running-ansible-through-ssh-jump-bastion-host.html#.YDq-H11KhpR
* https://blog.networktocode.com/post/ansible-bastion-host/
* https://leftasexercise.com/2019/12/23/using-ansible-with-a-jump-host/
* https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-configure-a-jump-host-to-access-servers-that-i-have-no-direct-access-to

* https://serverfault.com/questions/823687/ssh-keyscan-through-a-bastion
* https://stackoverflow.com/questions/10765946/ssh-use-known-hosts-other-than-home-ssh-known-hosts 

* https://dzone.com/articles/speed-up-ansible 

## Configure LDAP
* https://github.com/samrocketman/jenkins-bootstrap-shared/blob/main/scripts/configure-ldap-settings.groovy
* https://gist.github.com/zouzias/bf447ab020955ac70db5db5521c3d5b9
* https://stackoverflow.com/questions/46993653/ldap-groovy-script-runs-successfully-but-no-changes
* https://stackoverflow.com/questions/51250127/setting-up-of-ldapconfiguration-enviromental-properties-in-jenkins-using-groovy
* [Configure LDAP Authorization with Groovy](https://issues.jenkins.io/browse/JENKINS-29733)
* https://github.com/dennyzhang/cheatsheet-jenkins-groovy-A4/blob/master/enable-ldap.groovy
* https://github.com/dennyzhang/cheatsheet-jenkins-groovy-A4/blob/master/cheatsheet-jenkins-groovy-A4.pdf
* https://plugins.jenkins.io/ldap/ 
* https://github.com/hayderimran7/useful-jenkins-groovy-init-scripts
* https://stackoverflow.com/questions/35654286/how-to-check-if-a-file-exists-in-ansible



## DNS redirection to load balancer
* https://stackoverflow.com/questions/56713493/terraform-how-to-get-ip-address-of-aws-lb
* https://stackoverflow.com/questions/49761610/how-do-i-attach-an-elastic-ip-upon-creation-of-a-network-load-balancer-with-terr

## some commands
* checking if the port is open: `nc -zv 10.0.1.64 22`

* https://stackoverflow.com/questions/41424999/rendering-ansible-template-into-the-fact-variable
* https://github.com/jenkinsci/github-branch-source-plugin/blob/master/docs/github-app.adoc


## Paths:
* `/etc/default/cloudbees-core-cm` startup file
* Jenkins home: `/var/lib/cloudbees-core-oc`

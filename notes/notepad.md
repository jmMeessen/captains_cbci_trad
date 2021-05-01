## random notes

* `export ANSIBLE_SSH_ARGS="-F /Users/jmm/work/captains_cbci_trad/work_data/ssh_config"`
* `ansible-playbook --inventory-file=./work_data/inventory.yaml  ./deploy/test_hosts.yml`

* "There are some masters with an incompatible version of [ldap] installed. This will mean that should Operations Center be offline then you may not be able to log in on those masters. The affected masters are: [CM-1]"

ubuntu@ip-10-0-1-249:~$ sudo getent passwd cloudbees-core-oc
cloudbees-core-oc:x:113:119:CloudBees Core traditional - Operations Center,,,:/var/lib/cloudbees-core-oc:/bin/bash
ubuntu@ip-10-0-1-249:~$ sudo groups cloudbees-core-oc
cloudbees-core-oc : cloudbees-core-oc
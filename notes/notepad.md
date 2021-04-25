## random notes

* `export ANSIBLE_SSH_ARGS="-F /Users/jmm/work/captains_cbci_trad/work_data/ssh_config"`
* `ansible-playbook --inventory-file=./work_data/inventory.yaml  ./deploy/test_hosts.yml`

* "There are some masters with an incompatible version of [ldap] installed. This will mean that should Operations Center be offline then you may not be able to log in on those masters. The affected masters are: [CM-1]"

```
cloudbees-core-cm       soft    core    unlimited
cloudbees-core-cm       hard    core    unlimited
cloudbees-core-cm       soft    fsize   unlimited
cloudbees-core-cm       hard    fsize   unlimited
cloudbees-core-cm       soft    nofile  4096
cloudbees-core-cm       hard    nofile  8192
cloudbees-core-cm       soft    nproc   30654
cloudbees-core-cm       hard    nproc   30654
```
/etc/security/limits.conf
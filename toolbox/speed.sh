#!/bin/bash

start=`date +%s`

#export ANSIBLE_SSH_ARGS="-F /Users/jmm/work/captains_cbci_trad/work_data/ssh_config"
export ANSIBLE_SSH_ARGS="-F /Users/jmm/work/captains_cbci_trad/work_data/ssh_config -o ControlMaster=auto -o ControlPersist=60s"

# ansible-playbook -vvv --inventory-file=../work_data/inventory.yaml ../deploy/speed_test.yml -vvv -m ping
ansible-playbook -vvv --inventory-file=../work_data/inventory.yaml ../deploy/speed_test.yml 

end=`date +%s`
nbr_secs=`expr $end - $start`
nbr_min=`bc <<<"scale=1; $nbr_secs / 60"`
echo Execution time was ${nbr_min} minutes.
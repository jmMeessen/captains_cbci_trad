#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

#Use the default playbook unless one is defined as parameter
ansible_file="main_playbook.yml"
if [ $# -eq 1 ]
then
    ansible_file=$1
fi

#  Check if the file we are supposed to use exist
if [ ! -f ../deploy/${ansible_file} ]; then
    echo "\"../deploy/${ansible_file}\" not found!"
    exit
fi

echo "Executing ../deploy/${ansible_file}"

#Retrieve the github token from the local keystore
source ./get-github-token.sh


#
# Let's go
#
start=`date +%s`

set +e #we turn off failure on error so that we can execute the timing info
export ANSIBLE_SSH_ARGS="-F /Users/jmm/work/captains_cbci_trad/work_data/ssh_config -o ControlMaster=auto -o ControlPersist=60s"

ansible-playbook --inventory-file=../work_data/inventory.yaml --vault-password-file ../toolbox/.work-password ../deploy/${ansible_file}

end=`date +%s`
nbr_secs=`expr $end - $start`
nbr_min=`bc <<<"scale=1; $nbr_secs / 60"`
echo Execution time was ${nbr_min} minutes.
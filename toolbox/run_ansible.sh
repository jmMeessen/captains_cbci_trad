#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

ansible_file="main_playbook.yml"

# use a default vlaue or the parameter
# if [ $# -lt 1 ]
# then
#         echo "Usage : $0 ansibleFile in the deploy dir "
#         exit
# fi

source ./get-github-token.sh


start=`date +%s`

export ANSIBLE_SSH_ARGS="-F /Users/jmm/work/captains_cbci_trad/work_data/ssh_config -o ControlMaster=auto -o ControlPersist=60s"
ansible-playbook --inventory-file=../work_data/inventory.yaml --vault-password-file ../toolbox/.work-password ../deploy/${ansible_file}

end=`date +%s`
nbr_secs=`expr $end - $start`
nbr_min=`bc <<<"scale=1; $nbr_secs / 60"`
echo Execution time was ${nbr_min} minutes.
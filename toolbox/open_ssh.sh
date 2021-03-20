#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

# All nodes require a jump via the bastion by default
needs_jump="yes"

if [ $# -lt 1 ]
then
        echo "Usage : $0 nodeName"
        exit
fi

case "$1" in

bastion)  
    terraform_name="bastion_ip"
    needs_jump="no"
    ;;

jenkins)
    terraform_name="jenkins_ip"
    ;;

*) 
    echo "nodeName $1 is not supported"
    echo "supported node names are: bastion, jenkins"
    exit
    ;;
esac

echo "Starting SSH on $1"
#echo "$terraform_name"

if [ "$needs_jump" == "yes" ]; then
  node_ip=$(terraform output -raw -state=../terraform/terraform.tfstate $terraform_name 2>&1)
  echo "${terraform_name} (${node_ip}) via bastion"
  ssh -F ../work_data/ssh_config -J bastion  ubuntu@${node_ip} -i ~/.ssh/captains_cbci_trad 
else
  echo "Opening session to the bastion"
  ssh -F ../work_data/ssh_config bastion 
fi
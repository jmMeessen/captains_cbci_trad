#!/usr/bin/env bash

# All nodes require a jump via the bastion
needs_jump="yes"
bastion_ip=$(terraform output -raw -state=../terraform/terraform.tfstate bastion_ip 2>&1)

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
    echo "supported node names are: bastion"
    exit
    ;;
esac

echo "Starting SSH on $1"
#echo "$terraform_name"

node_ip=$(terraform output -raw -state=../terraform/terraform.tfstate $terraform_name 2>&1)

if [ "$needs_jump" == "yes" ]; then
  echo "${terraform_name} (${node_ip}) via bastion (${bastion_ip})"
  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -J ubuntu@${bastion_ip} -i ~/.ssh/captains_cbci_trad  ubuntu@${node_ip} -i ~/.ssh/captains_cbci_trad
else
  echo "${terraform_name} (${node_ip})"
  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${node_ip} -l ubuntu -i ~/.ssh/captains_cbci_trad
fi
#!/usr/bin/env bash

if [ $# -lt 1 ]
then
        echo "Usage : $0 nodeName"
        exit
fi

case "$1" in

bastion)  
    terraform_name="bastion_ip"
    ;;


*) echo "nodeName $1 is not supported"
   echo "supported node names are: bastion"
   exit
   ;;
esac

echo "Starting SSH on $1"
#echo "$terraform_name"

node_ip=$(terraform output -raw -state=../terraform/terraform.tfstate $terraform_name 2>&1)
echo "${terraform_name} (${node_ip})"
ssh ${node_ip} -l ubuntu -i ~/.ssh/captains_cbci_trad

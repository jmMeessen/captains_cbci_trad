#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return


source ~/.ovhrc

./update_aws_token.sh

cd ../terraform
echo "Refreshing the Terraform state"
terraform refresh

# delete the hostfile just in case
rm ../work_data/hostfile


echo "\nGathering data from terraform state"
the_bastion_ip=$(terraform output -raw bastion_ip 2>&1)
the_cjoc_ip=$(terraform output -raw cjoc_ip 2>&1)
the_cm1_ip=$(terraform output -raw cm1_ip 2>&1)
the_docker_agent_ip=$(terraform output -raw docker_agent_ip 2>&1)
the_agent1_ip=$(terraform output -raw agent1_ip 2>&1)

echo "\nWriting new \"ssh_config\" file."
#Read in template one line at the time, and replace variables (more
#natural (and efficient) way, thanks to Jonathan Leffler).
echo " " > ../work_data/ssh_config
while read line
do
    eval echo "$line" >> ../work_data/ssh_config
done < "../terraform/ssh-config.tpl"

echo "Done.\n"

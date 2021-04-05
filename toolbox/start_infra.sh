#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

start=`date +%s`

source ~/.ovhrc

./update_aws_token.sh

LOCAL_HOSTFILE=../work_data/hostfile
if [ -f "$LOCAL_HOSTFILE" ]; then
    echo "$LOCAL_HOSTFILE exists."
    rm $LOCAL_HOSTFILE
fi


cd ../terraform
terraform init
terraform validate
terraform fmt
terraform apply -auto-approve

#we need a local copy of the state so that we can query it with Ansible
terraform state pull > terraform.tfstate 
cd -

end=`date +%s`
nbr_secs=`expr $end - $start`
nbr_min=`bc <<<"scale=1; $nbr_secs / 60"`
echo Execution time was ${nbr_min} minutes.
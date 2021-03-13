#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

source ~/.ovhrc

./update_aws_token.sh

cd ../terraform
terraform init
terraform validate
terraform fmt
terraform apply -auto-approve

#we need a local copy of the state so that we can query it with Ansible
terraform state pull > terraform.tfstate 
cd -

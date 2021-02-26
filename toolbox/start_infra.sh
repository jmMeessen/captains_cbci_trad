#!/usr/bin/env bash
set -e
set -o pipefail

./update_aws_token.sh

cd ../terraform
terraform init
terraform validate
terraform fmt
terraform apply -auto-approve

#we need a local copy of the state so that we can query it with Ansible
terraform state pull > terraform.tfstate 
cd -

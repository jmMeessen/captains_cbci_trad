#!/usr/bin/env bash
set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

source ~/.ovhrc

./update_aws_token.sh

#./remove_ssh_known-host.sh

cd ../terraform
terraform destroy -auto-approve
rm terraform.tfstate
rm ssh_config
cd - 
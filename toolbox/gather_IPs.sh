#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return


echo ""
echo "Gathering IPs"

cd ../terraform

echo "  Jenkins"
export jenkins_ip=$(terraform output -raw -state=../terraform/terraform.tfstate jenkins_ip 2>&1)

cd -
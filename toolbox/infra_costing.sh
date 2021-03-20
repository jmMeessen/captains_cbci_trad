#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

start=`date +%s`

source ~/.ovhrc

./update_aws_token.sh

# Does a cost estimation based on the Terraform file
# Requires the infracost application (see https://infracost.io/docs)
# to install "brew install infracost"
# to request the key "infracost register" (the key is stored in ~/.config/infracost/credentials.yml)

infracost breakdown --path ../terraform --format json > ../notes/infra-cost.json
infracost output --path ../notes/infra-cost.json --format html > ../notes/infra-cost.html

open ../notes/infra-cost.html
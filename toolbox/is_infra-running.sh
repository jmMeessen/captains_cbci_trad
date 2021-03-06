#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

./update_aws_token.sh

aws --region us-east-1 --profile cloudbees-ps  ec2 describe-instances --filters "Name=tag:Owner,Values=Jmm" --output table --query "Reservations[*].Instances[*].{Name:Tags[?Key==\`Name\`] | [0].Value,State:State.Name}"
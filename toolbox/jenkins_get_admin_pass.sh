#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

host_name=jenkins

echo "Getting default password on ${host_name}"
echo " "
ssh -F ../work_data/ssh_config ${host_name} "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo " "

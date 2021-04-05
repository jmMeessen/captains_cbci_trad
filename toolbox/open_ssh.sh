#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return


PS3='Please enter your choice: '
options=("bastion" "cjoc" "docker_agent" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "bastion")
            echo "Connecting to ${opt}"
            ssh -F ../work_data/ssh_config ${opt}
            break
            ;;
        "cjoc")
            echo "Connecting to ${opt}"
            ssh -F ../work_data/ssh_config ${opt}
            break
            ;;
        "docker_agent")
            echo "Connecting to ${opt}"
            ssh -F ../work_data/ssh_config ${opt}
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

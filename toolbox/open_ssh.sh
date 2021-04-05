#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

if [ $# -eq 1 ]
then
    param=$1
    case $param in
        bastion|cjoc|cm1|agent_1|docker_agent)
            echo "Connecting to ${param}"
            ssh -F ../work_data/ssh_config ${param}
            break
            ;;
        *) echo "invalid option";;
    esac

    exit
fi

if [ $# -eq 0 ]
then
    PS3='Please enter your choice: '
    options=("bastion" "cjoc" "cm1" "agent_1" "docker_agent" "Quit")
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
            "cm1")
                echo "Connecting to ${opt}"
                ssh -F ../work_data/ssh_config ${opt}
                break
                ;;
            "agent_1")
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
fi
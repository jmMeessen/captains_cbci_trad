#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

# For consistant processing, CD to the Toolbox directory
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)" || return

source ~/.ovhrc

./update_aws_token.sh

start=`date +%s`

cd ../terraform
terraform destroy -auto-approve

#set +e
FILE=terraform.tfstate
if [ -f "$FILE" ]; then
    echo "deleting $FILE."
    rm $FILE
fi

FILE=../work_data/ssh_config
if [ -f "$FILE" ]; then
    echo "deleting $FILE."
    rm $FILE
fi

FILE=../work_data/hostfile
if [ -f "$FILE" ]; then
    echo "deleting $FILE."
    rm $FILE
fi

cd - 

end=`date +%s`
nbr_secs=`expr $end - $start`
nbr_min=`bc <<<"scale=1; $nbr_secs / 60"`
echo Execution time was ${nbr_min} minutes.
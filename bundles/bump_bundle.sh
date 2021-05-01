#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

#Update the default Controller unless one is defined as parameter
bundle_dir="CM1"
if [ $# -eq 1 ]
then
    bundle_dir=$1
fi

file_to_update="./${bundle_dir}/bundle.yaml"

#  Check if the file we are supposed to update exists
if [ ! -f ${file_to_update} ]; then
    echo "\"${file_to_update}\" not found!"
    exit
fi

echo "Updating ${file_to_update}"

the_date=$(date '+%y%m%d%H%M')
sed -i  's/version: "[0-9]*"/version: "'${the_date}'"/g' ${file_to_update}

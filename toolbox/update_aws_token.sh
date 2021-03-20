#!/usr/bin/env bash

set -e              #fail script when an instruction fails
set -o pipefail     #fails script a piped instruction fails
set -u              #fail script when a variable is uninitialised

opscore update
opscore iam refresh --account cloudbees-ps --role infra-admin
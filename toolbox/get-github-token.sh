#!/usr/bin/env bash

THIS_KEYCHAINUSER="jmm" 
THIS_KEYCHAINNAME="devops.keychain"
THIS_GITTOKENNAME="gitToken1"

export GITHUB_TOKEN=$( \
            security find-generic-password \
                -a ${THIS_KEYCHAINUSER} \
                -s ${THIS_GITTOKENNAME} \
                -w ${THIS_KEYCHAINNAME} 
            )

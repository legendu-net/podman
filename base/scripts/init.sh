#!/usr/bin/env bash

function scripts_etc.usage() {
    cat << EOF
NAME
    scripts_etc - configuration for init

SYNTAX 
    scripts_etc pre/post [upper_index]

ARGUMENT
    pre/post: Run scripts in /scripts/etc_pre or /scripts/etc_post respectively.
    upper_index: The maximum index of scripts to run.

DESCRIPTION
    Run scripts in /scripts/etc_pre or /scripts/etc_post 
    which are for automatic configurations in Docker container.

EOF
}

function scripts_etc() {
    local upper_index=9${2:-999}
    local script
    for script in $(ls /scripts/etc_$1/[0-9][0-9][0-9]-*.sh 2> /dev/null); do
        local index=$(basename $script)
        index=9${index:0:3}
        if [[ $index -le $upper_index ]]; then
            echo "Sourcing in the script $script ..."
            source $script
        fi
    done
}

scripts_etc pre
/scripts/launch.sh


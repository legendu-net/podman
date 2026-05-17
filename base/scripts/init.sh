#!/usr/bin/env bash

# _config pre/post
# Run scripts matching /scripts/pre-[0-9][0-9][0-9]-*.sh or
# /scripts/post-[0-9][0-9][0-9]-*.sh for automatic container configuration.
function _config() {
    local script
    for script in $(ls /scripts/$1-[0-9][0-9][0-9]-*.sh 2> /dev/null); do
        echo "Sourcing in the script $script ..."
        source $script
    done
}

function _launch() {
    local script=/scripts/launch.sh
    if [[ -f $script ]]; then
        echo "Launching application service using the script $script ..."
        $script &
    fi
}

_config pre
_launch
_config post


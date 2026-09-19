#!/usr/bin/env bash

# _config pre/post
# Run scripts matching /scripts/pre-[0-9][0-9][0-9]-*.sh or
# /scripts/post-[0-9][0-9][0-9]-*.sh for automatic container configuration.
function _config() {
    local script
    shopt -s nullglob
    for script in /scripts/"$1"-[0-9][0-9][0-9]-*.sh; do
        echo "Sourcing in the script $script ..."
        # shellcheck disable=SC1090
        source "$script"
    done
    shopt -u nullglob
}

function _launch() {
    local script=/scripts/launch.sh
    if [[ -f $script ]]; then
        echo "Launching application service using the script $script ..."
        nohup $script >/dev/null 2>&1 &
    fi
}

_config pre
_launch
_config post

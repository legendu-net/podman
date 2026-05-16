#!/usr/bin/env bash

function _copy_config {
    # $1: settings file
    # $2: sub dir
    local dir="$HOME/.jupyter/lab/user-settings/$2"
    mkdir -p "$dir"
    cp "/settings/$1" "$dir"
}

_copy_config commands.jupyterlab-settings @jupyterlab/codemirror-extension
_copy_config themes.jupyterlab-settings @jupyterlab/apputils-extension
_copy_config shortcuts.jupyterlab-settings @jupyterlab/shortcuts-extension
_copy_config jupyterlab-lsp.json @krassowski/jupyterlab-lsp/plugin.jupyterlab-settings
_copy_config settings.jupyterlab-settings jupyterlab_code_formatter
chown -R $DOCKER_USER:$DOCKER_GROUP $HOME/.jupyter

icon fish -c
icon nvim -c
nvim --headless '+Lazy! install' +qa &

#!/bin/bash

mkdir -p ~/.local/share/code-server/
export PASSWORD="$(id -un)" && /usr/bin/code-server \
    --bind-addr 0.0.0.0:8080 \
    --user-data-dir /etc/vscode/data \
    --disable-telemetry \
    --auth password \
    $HOME/ > ~/.local/share/code-server/code-server.log 2>&1

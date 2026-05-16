#!/usr/bin/env fish

argparse 'no-pull' 'no-push' -- $argv
or exit

if not set -q _flag_no_pull
    podman pull quay.io/legendu/jupyterhub-more:next
end
podman build -t quay.io/legendu/vscode-server:next .
#podman build --no-cache -t quay.io/legendu/vscode-server:next .
if not set -q _flag_no_push
    podman push quay.io/legendu/vscode-server:next
end

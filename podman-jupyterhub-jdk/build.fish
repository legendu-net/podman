#!/usr/bin/env fish

argparse 'no-pull' 'no-push' -- $argv
or exit

if not set -q _flag_no_pull
    podman pull quay.io/legendu/jupyterhub:next
end
podman build -t quay.io/legendu/jupyterhub-jdk:next .
if not set -q _flag_no_push
    podman push quay.io/legendu/jupyterhub-jdk:next
end

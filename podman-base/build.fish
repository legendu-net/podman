#!/usr/bin/env fish

argparse 'no-pull' 'no-push' 'no-cache' -- $argv
or exit

if not set -q _flag_no_pull
    podman pull registry.fedoraproject.org/fedora-toolbox:latest
end
if set -q _flag_no_cache
    podman build --no-cache -t quay.io/legendu/base:next .
else
    podman build -t quay.io/legendu/base:next .
end
if not set -q _flag_no_push
    podman push quay.io/legendu/base:next
end

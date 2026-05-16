#!/usr/bin/env fish

argparse 'no-pull' 'no-push' -- $argv
or exit

if not set -q _flag_no_pull
    podman pull fedora-toolbox:latest
end
podman build . -t quay.io/legendu/base:next
if not set -q _flag_no_push
    podman push quay.io/legendu/base:next
end

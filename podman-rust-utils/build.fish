#!/usr/bin/env fish

argparse 'no-pull' 'no-push' -- $argv
or exit

if not set -q _flag_no_pull
    podman pull quay.io/legendu/rust:next
end
podman build -t quay.io/legendu/rust-utils:next .
if not set -q _flag_no_push
    podman push quay.io/legendu/rust-utils:next
end

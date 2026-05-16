#!/usr/bin/env fish

function _show_help
    echo "Usage: build.fish [OPTIONS]"
    echo ""
    echo "Build the legendu/rust-cicd image from legendu/python:next."
    echo ""
    echo "Options:"
    echo "  --no-pull    Skip pulling quay.io/legendu/python:next"
    echo "  --no-push    Skip pushing quay.io/legendu/rust-cicd:next"
    echo "  --no-cache   Build without layer cache"
    echo "  -h, --help   Show this help message"
end

argparse 'h/help' 'no-pull' 'no-push' 'no-cache' -- $argv
or exit

if set -q _flag_help
    _show_help
    exit 0
end

if not set -q _flag_no_pull
    podman pull quay.io/legendu/python:next
end
if set -q _flag_no_cache
    podman build --no-cache -t quay.io/legendu/rust-cicd:next .
else
    podman build -t quay.io/legendu/rust-cicd:next .
end
if not set -q _flag_no_push
    podman push quay.io/legendu/rust-cicd:next
end

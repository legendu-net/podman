#!/usr/bin/env fish

function _show_help
    echo "Usage: build.fish [OPTIONS]"
    echo ""
    echo "Build the legendu/jupyterhub-ds image from legendu/jupyterhub-more:next."
    echo ""
    echo "Options:"
    echo "  --no-pull    Skip pulling quay.io/legendu/jupyterhub-more:next"
    echo "  --no-push    Skip pushing quay.io/legendu/jupyterhub-ds:next"
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
    podman pull quay.io/legendu/jupyterhub-more:next
end
if set -q _flag_no_cache
    podman build --no-cache -t quay.io/legendu/jupyterhub-ds:next .
else
    podman build -t quay.io/legendu/jupyterhub-ds:next .
end
if not set -q _flag_no_push
    podman push quay.io/legendu/jupyterhub-ds:next
end

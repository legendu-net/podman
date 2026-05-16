#!/usr/bin/env fish

function _show_help
    echo "Usage: build_all.fish [OPTIONS]"
    echo ""
    echo "Build all images listed in images.md in order."
    echo ""
    echo "Options:"
    echo "  --no-pull    Skip pulling base images"
    echo "  --no-push    Skip pushing built images"
    echo "  --no-cache   Build without layer cache"
    echo "  -h, --help   Show this help message"
end

argparse 'h/help' 'no-pull' 'no-push' 'no-cache' -- $argv
or exit

if set -q _flag_help
    _show_help
    exit 0
end

set script_dir (dirname (status filename))

for image in \
    podman-base \
    podman-rust \
    podman-rust-utils \
    podman-rust-cicd \
    podman-python-portable \
    podman-python \
    podman-python-nodejs \
    podman-jupyterlab \
    podman-jupyterhub \
    podman-jupyterhub-jdk \
    podman-jupyterhub-more \
    podman-vscode-server \
    podman-jupyterhub-ds \
    podman-jupyterhub-kotlin
    echo "==> Building $image"
    cd $script_dir/$image
    ./build.fish $_flag_no_pull $_flag_no_push $_flag_no_cach
    or exit
end

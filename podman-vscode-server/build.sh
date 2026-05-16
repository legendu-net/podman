#!/bin/bash

podman pull quay.io/dclong/jupyterhub-more:next
podman build -t quay.io/dclong/vscode-server:next .
#podman build --no-cache -t quay.io/dclong/vscode-server:next .

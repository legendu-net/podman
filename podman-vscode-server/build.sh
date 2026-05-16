#!/bin/bash

podman pull quay.io/legendu/jupyterhub-more:next
podman build -t quay.io/legendu/vscode-server:next .
#podman build --no-cache -t quay.io/legendu/vscode-server:next .

#!/bin/bash

podman pull dclong/jupyterhub-more:next
podman build -t dclong/vscode-server:next .
#podman build --no-cache -t dclong/vscode-server:next .

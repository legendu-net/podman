#!/bin/bash

podman pull quay.io/dclong/jupyterlab:next
podman build -t quay.io/dclong/jupyterhub:next .

#!/bin/bash

podman pull quay.io/legendu/jupyterlab:next
podman build -t quay.io/legendu/jupyterhub:next .
podman push quay.io/legendu/jupyterhub:next

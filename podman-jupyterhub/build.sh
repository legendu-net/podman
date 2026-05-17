#!/bin/bash

podman pull dclong/jupyterlab:next
podman build -t dclong/jupyterhub:next .

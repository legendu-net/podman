#!/bin/bash

podman pull quay.io/dclong/jupyterhub-more:next
podman build -t quay.io/dclong/jupyterhub-ds:next .

#!/bin/bash

podman pull quay.io/dclong/jupyterhub-jdk:next
podman build -t quay.io/dclong/jupyterhub-more:next .
#podman build --no-cache -t quay.io/dclong/jupyterhub-more:next .

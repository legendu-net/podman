#!/bin/bash

podman pull quay.io/legendu/jupyterhub-jdk:next
podman build -t quay.io/legendu/jupyterhub-more:next .
#podman build --no-cache -t quay.io/legendu/jupyterhub-more:next .
podman push quay.io/legendu/jupyterhub-more:next

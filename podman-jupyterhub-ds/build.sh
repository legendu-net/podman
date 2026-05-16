#!/bin/bash

podman pull quay.io/legendu/jupyterhub-more:next
podman build -t quay.io/legendu/jupyterhub-ds:next .
podman push quay.io/legendu/jupyterhub-ds:next

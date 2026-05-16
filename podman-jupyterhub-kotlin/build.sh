#!/bin/bash

podman build -t quay.io/legendu/jupyterhub-kotlin:next .
podman push quay.io/legendu/jupyterhub-kotlin:next

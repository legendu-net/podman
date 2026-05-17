#!/bin/bash

podman pull dclong/jupyterhub-jdk:next
podman build -t dclong/jupyterhub-more:next .
#podman build --no-cache -t dclong/jupyterhub-more:next .

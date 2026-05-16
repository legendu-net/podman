#!/bin/bash

podman pull quay.io/legendu/jupyterhub-jdk:next
podman build -t quay.io/legendu/jupyterhub-kotlin:next .
podman push quay.io/legendu/jupyterhub-kotlin:next

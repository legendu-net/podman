#!/bin/bash

podman pull quay.io/legendu/jupyterhub:next
podman build -t quay.io/legendu/jupyterhub-jdk:next .
podman push quay.io/legendu/jupyterhub-jdk:next

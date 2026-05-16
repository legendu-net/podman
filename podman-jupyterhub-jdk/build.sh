#!/bin/bash

podman build -t quay.io/legendu/jupyterhub-jdk:next .
podman push quay.io/legendu/jupyterhub-jdk:next

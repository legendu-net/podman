#!/bin/bash

podman pull dclong/jupyterhub-more:next
podman build -t dclong/jupyterhub-ds:next .

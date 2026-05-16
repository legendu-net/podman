#!/bin/bash

podman pull quay.io/dclong/python-nodejs:next
podman build -t quay.io/dclong/jupyterlab:next .

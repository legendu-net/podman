#!/bin/bash

podman pull quay.io/legendu/python-nodejs:next
podman build -t quay.io/legendu/jupyterlab:next .

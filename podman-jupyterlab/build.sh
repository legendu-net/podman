#!/bin/bash

podman pull dclong/python-nodejs:next
podman build -t dclong/jupyterlab:next .

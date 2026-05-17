#!/usr/bin/env fish

podman pull quay.io/legendu/python:next
podman build -t quay.io/legendu/python-nodejs:next .
podman push quay.io/legendu/python-nodejs:next

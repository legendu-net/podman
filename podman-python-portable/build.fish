#!/usr/bin/env fish

podman pull quay.io/legendu/base:next
podman build -t quay.io/legendu/python-portable:next .
podman push quay.io/legendu/python-portable:next

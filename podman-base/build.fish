#!/usr/bin/env fish

podman build . -t quay.io/legendu/base:next
podman push quay.io/legendu/base:next

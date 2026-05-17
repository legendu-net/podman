#!/usr/bin/env fish

podman pull quay.io/legendu/base:next
podman build -t quay.io/legendu/rust:next .
podman push quay.io/legendu/rust:next

#!/usr/bin/env fish

podman pull quay.io/legendu/rust:next
podman build -t quay.io/legendu/rust-utils:next .
podman push quay.io/legendu/rust-utils:next

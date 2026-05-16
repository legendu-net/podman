#!/bin/bash

podman build -t quay.io/legendu/rust-utils:next .
podman push quay.io/legendu/rust-utils:next

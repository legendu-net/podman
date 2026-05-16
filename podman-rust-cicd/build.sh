#!/bin/bash

podman pull quay.io/legendu/python:next
podman build -t quay.io/legendu/rust-cicd:next .
#podman build --no-cache -t quay.io/legendu/rust-cicd:next .
podman push quay.io/legendu/rust-cicd:next

#!/bin/bash

podman build -t quay.io/dclong/rust-cicd:next .
#podman build --no-cache -t quay.io/dclong/rust-cicd:next .

#!/bin/bash

podman build . -t quay.io/legendu/base:next
podman push quay.io/legendu/base:next

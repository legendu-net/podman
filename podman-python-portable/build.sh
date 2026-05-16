#!/bin/bash

podman build -t quay.io/legendu/python-portable:next .
podman push quay.io/legendu/python-portable:next

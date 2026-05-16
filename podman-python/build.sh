#!/bin/bash

podman pull quay.io/dclong/base:next
podman build -t quay.io/dclong/python:next .

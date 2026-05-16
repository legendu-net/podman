#!/bin/bash

podman pull quay.io/legendu/base:next
podman build -t quay.io/legendu/python:next .

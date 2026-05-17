#!/bin/bash

podman pull dclong/base:next
podman build -t dclong/python:next .

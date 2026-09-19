#!/bin/bash

mkdir -p ~/.local/share/jupyterhub/
jupyterhub -f /etc/jupyterhub/jupyterhub_config.py >~/.local/share/jupyterhub/jhub.log 2>&1

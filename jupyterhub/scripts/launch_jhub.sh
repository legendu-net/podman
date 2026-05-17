#!/bin/bash
# This script is for launching a JupyterHub service
# in situations where launch.sh in legendu/jupyterhub is overwritten (e.g., in legendu/vscode-server).

mkdir -p ~/.local/share/jupyterhub/
jupyterhub -f /etc/jupyterhub/jupyterhub_config.py > ~/.local/share/jupyterhub/jhub.log

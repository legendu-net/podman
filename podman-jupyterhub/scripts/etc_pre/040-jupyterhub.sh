#!/usr/bin/env bash

# add admin user to JupyterHub
sed -i "s/JUPYTERHUB_ADMIN_USER/${JUPYTERHUB_ADMIN_USER:-$(id -un)}/g" /etc/jupyterhub/jupyterhub_config.py

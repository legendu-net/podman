#!/usr/bin/env bash

# add admin user to JupyterHub
sed -i "s/JUPYTERHUB_ADMIN_USER/${JUPYTERHUB_ADMIN_USER:-$(id -un)}/g" /etc/jupyterhub/jupyterhub_config.py
# user memory limit
sed -i "s/USER_MEM_LIMIT/${USER_MEM_LIMIT:-4G}/g" /etc/jupyterhub/jupyterhub_config.py

#!/bin/bash
# This script is for launching a JupyterHub service
# in situations where launch.sh in dclong/jupyterhub is overwritten (e.g., in dclong/vscode-server).

cd $HOME
case "$(id -un)" in
    root )
        jupyterhub -f /etc/jupyterhub/jupyterhub_config.py
        ;;
    *)
        jupyterhub -f /etc/jupyterhub/jupyterhub_config.py --Spawner.notebook_dir=/workdir
esac

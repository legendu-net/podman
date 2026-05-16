#!/bin/bash
# This script is for launching a JupyterLab service 
# in situations where launch.sh in legendu/jupyterlab is overwritten (e.g., in legendu/vscode-server).

#/opt/venv/bin/jupyter lab --allow-root --ip='0.0.0.0' --port=8888 --no-browser --collaborative --notebook-dir=$HOME
/opt/venv/bin/jupyter lab --allow-root --ip='0.0.0.0' --port=8888 --no-browser --notebook-dir=$HOME


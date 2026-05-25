#!/bin/bash

mkdir -p ~/.local/share/jupyterlab/
/opt/venv/bin/jupyter lab \
    --allow-root \
    --ip='0.0.0.0' \
    --port=8888 \
    --no-browser \
    --notebook-dir=$HOME > ~/.local/share/jupyterlab/jlab.log 2>&1

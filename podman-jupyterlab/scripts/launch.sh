#!/bin/bash

#su -m $DOCKER_USER -c "jupyter lab --allow-root --ip='0.0.0.0' --port=8888 --no-browser --collaborative --notebook-dir=$HOME"
/opt/venv/bin/jupyter lab --allow-root --ip='0.0.0.0' --port=8888 --no-browser --notebook-dir=$HOME

#!/usr/bin/env bash

su -m $DOCKER_USER -c "icon zellij -c"

if [ -e "/workdir/.gemini" ]; then
    su --login $DOCKER_USER -c 'ln -snf /workdir/.gemini ~/.gemini'
fi

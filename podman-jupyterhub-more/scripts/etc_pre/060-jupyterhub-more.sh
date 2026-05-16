#!/usr/bin/env bash

icon zellij -c

if [ -e "/workdir/.gemini" ]; then
    ln -snf /workdir/.gemini ~/.gemini
fi

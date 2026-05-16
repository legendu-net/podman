#!/usr/bin/env bash

icon zellij -c

if [ -e "$HOME/.gemini" ]; then
    ln -snf $HOME/.gemini ~/.gemini
fi

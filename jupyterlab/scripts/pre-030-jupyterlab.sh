#!/usr/bin/env bash

# /settings/user-settings mirrors the layout of ~/.jupyter/lab/user-settings,
# so its content is copied over as is.
mkdir -p "$HOME/.jupyter/lab/user-settings"
cp -r /settings/user-settings/. "$HOME/.jupyter/lab/user-settings/"

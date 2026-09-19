#!/usr/bin/env bash

icon zellij -c
[[ -f ~/.local/bin/claude ]] || curl -fsSL https://claude.ai/install.sh | bash

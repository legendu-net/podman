#!/bin/bash

# purge dnf cache
if command -v dnf &>/dev/null; then
    dnf clean all
    rm -rf /var/cache/dnf
fi

# purge apt-get cache
if command -v apt-get &>/dev/null; then
    apt-get autoremove -y
    apt-get clean -y
fi

# purge pip cache
for cmd in python python3; do
    if command -v "$cmd" &>/dev/null; then
        $cmd -m pip cache purge -qqq
    fi
done

# purge conda cache
if command -v conda &>/dev/null; then
    conda clean --all --yes
fi

# purge npm cache
if command -v npm &>/dev/null; then
    npm cache clean --force
fi

# purge linuxbrew cache
if command -v brew &>/dev/null; then
    brew cleanup --prune=all
fi

# purge cargo cache
if command -v cargo-cache &>/dev/null; then
    cargo-cache --autoclean
elif [[ -f /root/.cargo/bin/cargo-cache ]]; then
    /root/.cargo/bin/cargo-cache --autoclean
elif [[ -f /usr/local/cargo/bin/cargo-cache ]]; then
    /usr/local/cargo/bin/cargo-cache --autoclean
elif [[ -f ~/.cargo/bin/cargo-cache ]]; then
    ~/.cargo/bin/cargo-cache --autoclean
fi

# purge Golang caches
if [[ "$GOPATH" != "" ]] && [[ -d "$GOPATH/pkg/mod/" ]]; then
    rm -rf "$GOPATH/pkg/mod/*"
fi
if [[ -d "$HOME/go/pkg/mod/" ]]; then
    rm -rf "$HOME/go/pkg/mod/"
fi

rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* ~/.config/ ~/.cache/

exit 0

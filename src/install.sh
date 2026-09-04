#!/bin/bash
set -ex
UID=${UID:-501}
GID=${GID:-501}

cat - >> $HOME/.bashrc <<EOF
export PATH="$HOME/.local/bin:\$PATH"
eval "\$(mise activate bash)"
EOF

mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

__install_zellij() {
  mkdir -p "$HOME/.config/zellij/"
  zellij setup --dump-config > "$HOME/.config/zellij/config.kdl"
}

__install_deps() {
  \. "$HOME/.nvm/nvm.sh"

  nvm install 24

  npm i -g opencode-ai

  npm install -g --ignore-scripts @earendil-works/pi-coding-agent
}

__install_zellij
__install_deps

#!/bin/bash
set -ex

__install_zellij() {
  dir="/usr/local/bin"
  mkdir -p "$dir"

  case $(uname -m) in
      "x86_64"|"aarch64")
          arch=$(uname -m)
      ;;
      "arm64")
          arch="aarch64"
      ;;
      *)
          echo "Unsupported cpu arch: $(uname -m)"
          exit 2
      ;;
  esac

  case $(uname -s) in
      "Linux")
          sys="unknown-linux-musl"
      ;;
      "Darwin")
          sys="apple-darwin"
      ;;
      *)
          echo "Unsupported system: $(uname -s)"
          exit 2
      ;;
  esac

  url="https://github.com/zellij-org/zellij/releases/latest/download/zellij-$arch-$sys.tar.gz"
  curl --silent --location "$url" | tar -C "$dir" -xz
  if [[ $? -ne 0 ]]; then
      echo
      echo "Extracting binary failed, cannot launch zellij"
      exit 1
  fi

  mkdir -p "$HOME/.config/zellij/"
  zellij setup --dump-config > "$HOME/.config/zellij/config.kdl"
}

__install_mise() {
  version=v2026.9.1

  case $(uname -m) in
      "aarch64")
          arch="arm64"
      ;;
      *)
          echo "Unsupported cpu arch: $(uname -m)"
          exit 2
      ;;
  esac

  case $(uname -s) in
      "Linux")
          sys="linux"
      ;;
      *)
          echo "Unsupported system: $(uname -s)"
          exit 2
      ;;
  esac

  sudo curl -sfL https://github.com/jdx/mise/releases/download/${version}/mise-${version}-${sys}-${arch} -o /usr/local/bin/mise
  sudo chmod a+x /usr/local/bin/mise

  cat - >> $HOME/.bashrc <<EOF
export PATH="$HOME/.local/bin:$PATH"
eval "\$(mise activate bash)"
EOF

}

__install_tini() {
  case $(uname -m) in
      "aarch64")
          arch="arm64"
      ;;
      *)
          echo "Unsupported cpu arch: $(uname -m)"
          exit 2
      ;;
  esac

  sudo curl -fsL https://github.com/krallin/tini/releases/download/v0.19.0/tini-$arch -o /usr/local/bin/tini
  sudo chmod a+x /usr/local/bin/tini
}

__install_deps() {
  sudo dnf install java-latest-openjdk-headless yq jq rustup git -y
}

__install_claude() {
  curl -fsSL https://claude.ai/install.sh | bash
}

__install_tini
# __install_zellij
__install_mise
__install_claude
__install_deps

#!/bin/bash
set -ex

DOWNLOAD_DIR="$HOME/downloads"
mkdir -p "$DOWNLOAD_DIR"

__download_zellij() {
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
  curl --silent --location "$url" | tar -C "$DOWNLOAD_DIR" -xz
}

__download_mise() {
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

  curl -sfL "https://github.com/jdx/mise/releases/download/${version}/mise-${version}-${sys}-${arch}" -o "$DOWNLOAD_DIR/mise"
}

__download_zellij
__download_mise

chmod a+x $DOWNLOAD_DIR/*
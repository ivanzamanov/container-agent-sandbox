#!/bin/bash
set -ex

echo "Started sandbox"

source ~/.bashrc

zellij web --daemonize

exec opencode web --port 4444 --hostname 0.0.0.0

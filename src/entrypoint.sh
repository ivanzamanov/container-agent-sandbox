#!/bin/bash
set -ex

echo "Started sandbox"

source ~/.bashrc

zellij web --port 8082 --daemonize --ip 127.0.0.2

socat TCP-LISTEN:8082,bind=0.0.0.0,fork TCP:127.0.0.2:8082 &

exec opencode web --port 4444 --hostname 0.0.0.0

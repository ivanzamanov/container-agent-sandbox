#!/bin/bash
set -ex

echo "Started sandbox"

source ~/.bashrc
exec opencode web --port 4444 --hostname 0.0.0.0

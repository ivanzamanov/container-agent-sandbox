#!/bin/bash
set -ex

echo "Started sandbox"

source ~/.bashrc
exec botctl --web-ui

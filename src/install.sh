#!/bin/bash
set -ex
UID=${UID:-501}
GID=${GID:-501}

bash /tmp/src/install-tools.sh

sudo cp /tmp/src/entrypoint.sh /
sudo chmod +x /entrypoint.sh

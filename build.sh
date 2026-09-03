#!/bin/bash
podman build --tag docker.io/library/agent-sandbox-sandbox \
  --file src/Sandbox.Dockerfile \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  .
  
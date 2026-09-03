#!/bin/bash
podman build --tag docker.io/library/container-agent-sandbox \
  --file src/Sandbox.Dockerfile \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  .
  
# container-agent-sandbox

A disposable container for running coding agents.

All network egress is forced through an HTTP proxy.
Only a few directories are mounted inside the container.

## Quickstart
First off, adjust the GID and UID in `docker-compose.yaml`. Then:

```sh
podman compose up -d --build      # or: docker compose up -d, if pointed at the same podman socket
podman exec -it agent-sandbox-claude-1 bash
```

## Claude

Inside the container, run `claude` and complete the login flow once — credentials persist across container recreation.

## Sudo & capabilities

The `agent` user has passwordless `sudo` so it can install packages (`dnf`, language toolchains, etc.).

## Tooling baked into the image

Installed by `src/install.sh` → `src/install-tools.sh` (Fedora base):

- `tini` — PID 1 / init, reaps zombie processes.
- `mise` — polyglot tool version manager; default tools come from `src/mise-config.toml`.
- The `claude` CLI (Claude Code).
- `dnf`-installed: `java-latest-openjdk-headless`, `yq`, `jq`, `rustup`, `git`.

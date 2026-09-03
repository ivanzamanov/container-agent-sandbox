FROM registry.fedoraproject.org/fedora:44

ARG UID
ARG GID

RUN groupadd -g $GID agent || true ; \
useradd --create-home --shell /bin/bash --uid $UID --gid $GID agent && \
echo "agent ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/agent && \
echo 'Defaults:agent env_keep += "HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy"' >> /etc/sudoers.d/agent && \
chmod 0440 /etc/sudoers.d/agent

USER agent
RUN --mount=type=bind,source=src,target=/tmp/src,rw bash /tmp/src/install.sh

WORKDIR /home/agent

ENTRYPOINT ["/usr/local/bin/tini", "--" ]
CMD ["/entrypoint.sh"]

FROM registry.fedoraproject.org/fedora:44 as builder

ARG DOWNLOAD_DIR=/root/downloads/
ADD src/download.sh download.sh
ADD src/botctl-install.sh botctl-install.sh

RUN bash download.sh && bash botctl-install.sh && \
  mv /usr/local/bin/botctl ${DOWNLOAD_DIR}

FROM registry.fedoraproject.org/fedora:44

ARG UID
ARG GID

RUN groupadd -g $GID agent || true ; \
  useradd --create-home --shell /bin/bash --uid $UID --gid $GID agent

RUN dnf install -y procps-ng libatomic1 java-latest-openjdk-headless yq jq rustup git golang vim && \
  dnf clean all

USER agent
WORKDIR /home/agent

RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.7/install.sh | bash
RUN curl -fsSL https://claude.ai/install.sh | bash

COPY --from=builder /root/downloads/* /usr/local/bin/

ADD src/install.sh /tmp/install.sh
RUN bash /tmp/install.sh

ADD src/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 4444
EXPOSE 8082

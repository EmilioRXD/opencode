FROM ghcr.io/anomalyco/opencode:latest

USER root

# Alpine usa apk (no apt-get)
RUN apk update && apk add --no-cache \
    git \
    curl \
    wget \
    unzip \
    ca-certificates \
    gnupg \
    bash \
    build-base \
    python3 \
    py3-pip \
    openssh-client \
    jq \
    ripgrep

# Node.js LTS + npm
RUN apk add --no-cache nodejs npm

# pnpm y yarn
RUN npm install -g pnpm yarn

# Bun (requiere bash, ya instalado arriba)
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Configuración de git
RUN git config --system core.autocrlf input && \
    git config --system init.defaultBranch main

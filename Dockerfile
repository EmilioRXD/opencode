FROM ghcr.io/anomalyco/opencode:latest

USER root

# Instalar dependencias base (Alpine usa apk, no apt-get)
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

# Instalar Node.js LTS + npm (Alpine compatible)
RUN apk add --no-cache nodejs npm

# Instalar pnpm y yarn globalmente
RUN npm install -g pnpm yarn

# Instalar Bun (requiere bash, ya instalado arriba)
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Configurar git con valores por defecto seguros
RUN git config --system core.autocrlf input && \
    git config --system init.defaultBranch main

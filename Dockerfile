FROM ghcr.io/anomalyco/opencode:latest

USER root

# Instalar dependencias base
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    unzip \
    ca-certificates \
    gnupg \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    openssh-client \
    jq \
    ripgrep \
    && rm -rf /var/lib/apt/lists/*

# Instalar Node.js (LTS via NodeSource)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Instalar pnpm y yarn globalmente
RUN npm install -g pnpm yarn

# Instalar Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Configurar git con valores por defecto seguros
RUN git config --system core.autocrlf input && \
    git config --system init.defaultBranch main

# Volver al usuario original si la imagen base lo define
# USER opencode


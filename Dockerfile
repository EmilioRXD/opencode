FROM smanx/opencode:latest

USER root

# Instalar herramientas de desarrollo adicionales (Ubuntu/Debian con apt-get)
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

# Node.js LTS via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# pnpm y yarn
RUN npm install -g pnpm yarn

# Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Configuración de git
RUN git config --system core.autocrlf input && \
    git config --system init.defaultBranch main

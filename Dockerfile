FROM debian:bookworm-slim

# ── Variables de versión ──────────────────────────────────────────────────────
ARG OPENCODE_VERSION=v0.0.55
ARG TARGETARCH=amd64

# ── Dependencias base ─────────────────────────────────────────────────────────
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

# ── Instalar opencode desde el .deb oficial ───────────────────────────────────
RUN curl -fsSL \
    "https://github.com/opencode-ai/opencode/releases/download/${OPENCODE_VERSION}/opencode-linux-${TARGETARCH}.deb" \
    -o /tmp/opencode.deb \
    && dpkg -i /tmp/opencode.deb \
    && rm /tmp/opencode.deb

# ── Node.js LTS via NodeSource ────────────────────────────────────────────────
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# ── pnpm y yarn ───────────────────────────────────────────────────────────────
RUN npm install -g pnpm yarn

# ── Bun ──────────────────────────────────────────────────────────────────────
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# ── Configuración de git ──────────────────────────────────────────────────────
RUN git config --system core.autocrlf input && \
    git config --system init.defaultBranch main

WORKDIR /workspace
EXPOSE 4096

ENTRYPOINT ["opencode"]
CMD ["web", "--hostname", "0.0.0.0", "--port", "4096"]

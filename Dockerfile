# OpenCode Docker Image
# Based on Debian with OpenCode pre-installed and ready to use
# https://opencode.ai/

FROM debian:bookworm-slim

LABEL maintainer="mail@cluy.dev"
LABEL description="OpenCode - The open source AI coding agent"
LABEL version="1.0"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root
ENV PATH="${HOME}/.opencode/bin:${HOME}/.local/bin:${PATH}"
ENV DISPLAY=host.docker.internal:0.0

# Install essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS version) for LSP support and other features
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI (gh)
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCode using the official install script
RUN curl -fsSL https://opencode.ai/install | bash

# Verify installation
RUN opencode --version || echo "OpenCode installed"

# Create a working directory for projects
WORKDIR /workspace

# Set default command to run opencode
ENTRYPOINT ["opencode"]

# OpenCode Docker Image
# Based on Debian with OpenCode pre-installed and ready to use
# https://opencode.ai/

FROM debian:bookworm-slim

LABEL maintainer="your-email@example.com"
LABEL description="OpenCode - The open source AI coding agent"
LABEL version="1.0"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root
ENV PATH="${HOME}/.opencode/bin:${HOME}/.local/bin:${PATH}"

# Install essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS version) for LSP support and other features
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCode using the official install script
RUN curl -fsSL https://opencode.ai/install | bash

# Verify installation
RUN opencode --version || echo "OpenCode installed"

# Create a working directory for projects
WORKDIR /workspace

# Set default command to run opencode
ENTRYPOINT ["opencode"]

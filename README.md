# OpenCode Docker Image

A Debian-based Docker image with [OpenCode](https://opencode.ai/) pre-installed and ready to use.

## What is OpenCode?

OpenCode is an open source AI coding agent that helps you write code in your terminal, IDE, or desktop. It supports 75+ LLM providers including Claude, GPT, Gemini, and more.

## Quick Start

### Build the Image

```bash
docker build -t opencode .
```

### Run OpenCode

To use OpenCode with a project directory:

```bash
docker run -it --rm \
  -v /path/to/your/project:/workspace \
  -e OPENCODE_API_KEY=your_api_key \
  opencode
```

### Using with Different Providers

OpenCode supports multiple LLM providers. Set the appropriate environment variables:

**OpenCode Zen (Recommended):**
```bash
docker run -it --rm \
  -v /path/to/your/project:/workspace \
  -e OPENCODE_API_KEY=your_opencode_api_key \
  opencode
```

**Anthropic (Claude):**
```bash
docker run -it --rm \
  -v /path/to/your/project:/workspace \
  -e ANTHROPIC_API_KEY=your_anthropic_api_key \
  opencode
```

**OpenAI:**
```bash
docker run -it --rm \
  -v /path/to/your/project:/workspace \
  -e OPENAI_API_KEY=your_openai_api_key \
  opencode
```

**Google (Gemini):**
```bash
docker run -it --rm \
  -v /path/to/your/project:/workspace \
  -e GOOGLE_API_KEY=your_google_api_key \
  opencode
```

## Configuration

You can mount a configuration file to persist settings:

```bash
docker run -it --rm \
  -v /path/to/your/project:/workspace \
  -v ~/.config/opencode:/root/.config/opencode \
  opencode
```

## Features

- ✅ **LSP enabled** - Automatically loads the right LSPs for the LLM
- ✅ **Multi-session** - Start multiple agents in parallel on the same project
- ✅ **Any model** - 75+ LLM providers through Models.dev, including local models
- ✅ **Debian-based** - Reliable and widely compatible base image
- ✅ **Node.js included** - For LSP support and JavaScript/TypeScript projects

## Docker Compose

Create a `docker-compose.yml` for easier usage:

```yaml
version: '3.8'

services:
  opencode:
    build: .
    stdin_open: true
    tty: true
    volumes:
      - ./project:/workspace
      - ~/.config/opencode:/root/.config/opencode
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
```

Then run:
```bash
docker compose run --rm opencode
```

## Links

- [OpenCode Website](https://opencode.ai/)
- [OpenCode Documentation](https://opencode.ai/docs)
- [GitHub Repository](https://github.com/anomalyco/opencode)

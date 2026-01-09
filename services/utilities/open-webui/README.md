# Open WebUI

Extensible, feature-rich, and user-friendly web interface for Ollama. ChatGPT-style interface for local LLMs.

## Overview

Open WebUI (formerly Ollama WebUI) is a self-hosted web client for Ollama, providing an intuitive interface for interacting with large language models running locally.

## Features

- ChatGPT-style interface
- Model management (pull, delete, update)
- Conversation history
- Multiple chat sessions
- Markdown rendering
- Code syntax highlighting
- User authentication
- Multi-user support
- RAG (Retrieval Augmented Generation) support
- Document uploads
- Image generation support

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration
nano .env

# Start service (requires Ollama to be running)
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Edit configuration
notepad .env

# Start service (requires Ollama to be running)
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| OPEN_WEBUI_VERSION | main | Open WebUI version/tag |
| OPEN_WEBUI_PORT | 3000 | Web UI port |
| OLLAMA_BASE_URL | http://ollama:11434 | Ollama API endpoint |
| WEBUI_AUTH | true | Enable authentication |
| WEBUI_NAME | Open WebUI | Application name |

## Accessing the Service

After starting:

- **Web UI**: http://localhost:3000

**First run:**
1. Create an admin account (first user is admin)
2. Sign in
3. Start chatting with models

## Prerequisites

This service requires a running Ollama instance with models installed.

**Using composition:**
```yaml
services:
  ollama:
    extends:
      file: ../../services/ai-ml/ollama/docker-compose.yml
      service: ollama
    networks:
      - ollama-network

  open-webui:
    extends:
      file: ../../services/utilities/open-webui/docker-compose.yml
      service: open-webui
    networks:
      - ollama-network

networks:
  ollama-network:
```

## Using the Interface

### Pull a Model

1. Click the model dropdown
2. Select "Pull a model from Ollama.com"
3. Enter model name (e.g., `llama2`, `mistral`)
4. Click "Pull"

### Start a Chat

1. Select a model from dropdown
2. Type your message
3. Press Enter or click Send

### Upload Documents (RAG)

1. Click the document icon
2. Upload PDF, TXT, or other documents
3. Ask questions about the document content

### Manage Conversations

- **New Chat**: Click "+" button
- **View History**: Click history icon
- **Delete Chat**: Click trash icon
- **Export Chat**: Click export button

## Connecting to Host Ollama

If Ollama is running on the host machine (not in Docker):

**Linux/macOS:**
```bash
# Set in .env
OLLAMA_BASE_URL=http://host.docker.internal:11434
```

**Linux (alternative):**
```bash
# Use host network or host IP
OLLAMA_BASE_URL=http://172.17.0.1:11434
```

## Multi-User Setup

When WEBUI_AUTH is enabled:
- First user becomes admin
- Admin can manage users
- Each user has their own chat history
- Conversations are private

## Persistent Volumes

This service uses one persistent volume:

- **open-webui-data**: User data, chat history, settings (`/app/backend/data`)

Data persists across container restarts.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  open-webui:
    extends:
      file: ../../services/utilities/open-webui/docker-compose.yml
      service: open-webui
```

## Health Check

```bash
curl -I http://localhost:3000
```

## Troubleshooting

**Cannot connect to Ollama:**
- Ensure Ollama is running
- Check OLLAMA_BASE_URL environment variable
- Verify network connectivity
- Test Ollama directly: `curl http://ollama:11434/api/tags`

**No models available:**
- Pull models in Ollama first: `docker exec ollama ollama pull llama2`
- Or use Open WebUI's model management interface

**Authentication issues:**
- To disable auth (dev only): Set WEBUI_AUTH=false
- Clear browser cache/cookies
- Check browser console for errors

## Documentation

- Official Website: https://openwebui.com/
- GitHub: https://github.com/open-webui/open-webui
- Ollama Models: https://ollama.com/library

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.open-webui.yml`

---

**Service Type:** Utility (Web Interface for LLMs)
**Category:** AI/ML Interface
**Deployment:** Standalone container with persistence (requires Ollama)

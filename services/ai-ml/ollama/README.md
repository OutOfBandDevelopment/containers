# Ollama LLM Service

Large Language Model inference server supporting multiple models.

## Overview

Ollama provides a simple API for running LLMs locally. Supports models like Llama 2, CodeLlama, Mistral, and more.

## Quick Start

### Standalone Usage

```bash
cd services/ai-ml/ollama
cp .env.template .env
docker compose up -d
```

Access at: http://localhost:11434

### Composed with Other Services

```bash
# Start Ollama + Qdrant + Open WebUI
docker compose \
  -f services/ai-ml/ollama/docker-compose.yml \
  -f services/ai-ml/qdrant/docker-compose.yml \
  -f services/utilities/open-webui/docker-compose.yml \
  up -d
```

## Configuration

### Environment Variables

| Variable | Default | Description |
|:---------|:--------|:------------|
| OLLAMA_PORT | 11434 | HTTP API port |

### Volumes

| Volume | Purpose |
|:-------|:--------|
| ollama-data | Model storage and cache |

### Ports

| Port | Service |
|:-----|:--------|
| 11434 | HTTP API |

## Usage Examples

### Pull a Model

```bash
docker exec ollama ollama pull llama2
```

### List Models

```bash
docker exec ollama ollama list
```

### Generate Text (API)

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt": "Why is the sky blue?"
}'
```

### Chat Completion (API)

```bash
curl http://localhost:11434/api/chat -d '{
  "model": "llama2",
  "messages": [
    {"role": "user", "content": "Hello!"}
  ]
}'
```

## GPU Support

For GPU acceleration:

1. Install NVIDIA Container Toolkit
2. Uncomment GPU configuration in docker-compose.yml:

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: 1
          capabilities: [gpu]
```

3. Start the service

## Composition Examples

This service works well with:

- **examples/full-ai-ml-stack/** - Complete AI/ML environment
- **services/ai-ml/qdrant/** - Vector database for RAG
- **services/utilities/open-webui/** - Chat interface for Ollama

## API Documentation

Full API documentation: https://github.com/ollama/ollama/blob/main/docs/api.md

## Supported Models

- Llama 2 (7B, 13B, 70B)
- Code Llama
- Mistral
- Mixtral
- And many more...

See: https://ollama.ai/library

---

**Source:** Migrated from AnotherOneBytesTheDust/ContainerStore
**Category:** AI/ML
**Type:** LLM Inference Server

# Qdrant Vector Database

High-performance vector database for AI/ML applications with support for similarity search.

## Overview

Qdrant is a vector database that provides fast and scalable similarity search. It's designed for production-ready AI/ML applications requiring semantic search, recommendations, and other vector-based operations.

## Features

- Fast vector similarity search
- Filtering and payload support
- Horizontal scaling
- REST and gRPC APIs
- Snapshot support for backups

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration if needed
nano .env

# Start service
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Edit configuration if needed
notepad .env

# Start service
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| QDRANT_VERSION | latest | Qdrant image version |
| QDRANT_HTTP_PORT | 6333 | REST API port |
| QDRANT_GRPC_PORT | 6334 | gRPC API port |
| QDRANT_ALLOW_RECOVERY_MODE | false | Enable recovery mode |

## Accessing the Service

After starting:

- **REST API**: http://localhost:6333
- **gRPC API**: localhost:6334
- **Web UI**: http://localhost:6333/dashboard

## API Examples

**Create a collection:**
```bash
curl -X PUT 'http://localhost:6333/collections/my_collection' \
  -H 'Content-Type: application/json' \
  -d '{
    "vectors": {
      "size": 384,
      "distance": "Cosine"
    }
  }'
```

**Insert a vector:**
```bash
curl -X PUT 'http://localhost:6333/collections/my_collection/points' \
  -H 'Content-Type: application/json' \
  -d '{
    "points": [
      {
        "id": 1,
        "vector": [0.1, 0.2, ...],
        "payload": {"text": "example"}
      }
    ]
  }'
```

**Search:**
```bash
curl -X POST 'http://localhost:6333/collections/my_collection/points/search' \
  -H 'Content-Type: application/json' \
  -d '{
    "vector": [0.1, 0.2, ...],
    "limit": 10
  }'
```

## Persistent Volumes

This service uses two persistent volumes:

- **qdrant-storage**: Main data storage (`/qdrant/storage`)
- **qdrant-snapshots**: Backup snapshots (`/qdrant/snapshots`)

Data persists across container restarts.

## Backup & Restore

**Create snapshot:**
```bash
curl -X POST 'http://localhost:6333/collections/my_collection/snapshots'
```

**List snapshots:**
```bash
curl 'http://localhost:6333/collections/my_collection/snapshots'
```

**Restore from snapshot:**
```bash
curl -X PUT 'http://localhost:6333/collections/my_collection/snapshots/upload' \
  -F 'snapshot=@snapshot.snapshot'
```

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  qdrant:
    extends:
      file: ../../services/databases/qdrant/docker-compose.yml
      service: qdrant
```

## Health Check

```bash
curl http://localhost:6333/healthz
```

## Documentation

- Official Docs: https://qdrant.tech/documentation/
- API Reference: https://qdrant.github.io/qdrant/redoc/
- GitHub: https://github.com/qdrant/qdrant

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.qdrant.yml`

---

**Service Type:** Database (Vector Database)
**Category:** AI/ML Infrastructure
**Deployment:** Standalone container

# OpenSearch

Open-source search and analytics engine forked from Elasticsearch, providing full-text search, log analytics, and real-time application monitoring.

## Overview

OpenSearch is a community-driven, Apache 2.0-licensed search and analytics suite derived from Elasticsearch 7.10.2. It provides powerful search capabilities, data visualization, and security features.

## Features

- Full-text search engine
- Log analytics
- Real-time application monitoring
- JSON-based REST API
- Horizontal scalability
- Security and authentication
- SQL support
- Vector search capabilities

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration (IMPORTANT: Change admin password)
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

# Edit configuration (IMPORTANT: Change admin password)
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
| OPENSEARCH_VERSION | latest | OpenSearch image version |
| OPENSEARCH_PORT | 9200 | HTTP API port |
| OPENSEARCH_PERF_PORT | 9600 | Performance analyzer port |
| OPENSEARCH_ADMIN_PASSWORD | YourStrong@Password | Admin password (CHANGE THIS!) |
| OPENSEARCH_JAVA_OPTS | -Xms512m -Xmx512m | JVM heap size settings |
| OPENSEARCH_MEMORY_LOCK | true | Prevent heap swapping |
| OPENSEARCH_SSL_HTTP | false | Enable HTTPS |

## Accessing the Service

After starting:

- **REST API**: http://localhost:9200
- **Performance Analyzer**: http://localhost:9600/_plugins/_performanceanalyzer/metrics

## API Examples

**Health check:**
```bash
curl -X GET "http://localhost:9200/_cluster/health?pretty" \
  -u admin:YourStrong@Password
```

**Create an index:**
```bash
curl -X PUT "http://localhost:9200/my-index" \
  -u admin:YourStrong@Password \
  -H 'Content-Type: application/json' \
  -d '{
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 1
    }
  }'
```

**Index a document:**
```bash
curl -X POST "http://localhost:9200/my-index/_doc" \
  -u admin:YourStrong@Password \
  -H 'Content-Type: application/json' \
  -d '{
    "title": "Example Document",
    "content": "This is sample content for full-text search"
  }'
```

**Search:**
```bash
curl -X GET "http://localhost:9200/my-index/_search?pretty" \
  -u admin:YourStrong@Password \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "match": {
        "content": "sample"
      }
    }
  }'
```

## Persistent Volumes

This service uses one persistent volume:

- **opensearch-data**: Main data storage (`/usr/share/opensearch/data`)

Data persists across container restarts.

## Memory Configuration

OpenSearch requires sufficient memory. The default configuration uses 512MB heap size, suitable for development. For production:

```bash
# Edit .env file
OPENSEARCH_JAVA_OPTS=-Xms2g -Xmx2g
```

Recommendation: Set heap to ~50% of available RAM, never exceed 32GB.

## System Requirements

- Minimum 2GB RAM
- vm.max_map_count set to at least 262144

**Linux/macOS:**
```bash
sudo sysctl -w vm.max_map_count=262144
```

**Windows (WSL2):**
```powershell
wsl -d docker-desktop sysctl -w vm.max_map_count=262144
```

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  opensearch:
    extends:
      file: ../../services/databases/opensearch/docker-compose.yml
      service: opensearch
```

## OpenSearch Dashboards

For a web UI, pair with OpenSearch Dashboards (see utilities/opensearch-dashboards).

## Documentation

- Official Docs: https://opensearch.org/docs/latest/
- API Reference: https://opensearch.org/docs/latest/api-reference/
- GitHub: https://github.com/opensearch-project/OpenSearch

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.opensearch.yml`

---

**Service Type:** Database (Search Engine)
**Category:** Search & Analytics
**Deployment:** Standalone container (single-node)

# SearXNG

Privacy-respecting metasearch engine that aggregates results from multiple search engines.

## Overview

SearXNG is a free internet metasearch engine which aggregates results from more than 70 search services. Users are neither tracked nor profiled. Perfect for privacy-focused search, research, and integration into AI applications.

## Features

- **Privacy-respecting**: No tracking, no profiling
- **Multi-engine search**: Aggregates 70+ search engines
- **Customizable**: Configure search engines and categories
- **JSON API**: Programmable search interface
- **Lightweight**: Fast and efficient
- **Self-hosted**: Complete control over your search

## Quick Start

```bash
cd services/utilities/searxng
./start.sh

# Access at http://localhost:8080
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| SEARXNG_VERSION | latest | Image version/tag |
| SEARXNG_PORT | 8080 | Web interface port |
| SEARXNG_BASE_URL | http://localhost:8080/ | Base URL (for reverse proxy) |
| SEARXNG_SECRET | ultrasecretkey | Session secret (CHANGE THIS!) |

**Important:** Change SEARXNG_SECRET before deploying!

## Usage Examples

### Web Search

Visit http://localhost:8080 and search normally.

### JSON API

```bash
curl "http://localhost:8080/search?q=python&format=json"
```

### Python Integration

```python
import requests

response = requests.get('http://localhost:8080/search', params={
    'q': 'artificial intelligence',
    'format': 'json',
    'categories': 'general'
})

results = response.json()['results']
for result in results:
    print(f"{result['title']}: {result['url']}")
```

### Advanced Search

```bash
# Search in specific category
curl "http://localhost:8080/search?q=docker&format=json&categories=it"

# Search with specific engine
curl "http://localhost:8080/search?q=news&format=json&engines=google"
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| searxng-data | /etc/searxng | Configuration and settings | <100MB |

## Use in Compositions

```yaml
services:
  searxng:
    extends:
      file: ../../services/utilities/searxng/docker-compose.yml
      service: searxng
    networks:
      - app-network
    environment:
      - SEARXNG_BASE_URL=http://myserver/searxng/
```

## Behind Reverse Proxy

When using behind nginx or other reverse proxy, set SEARXNG_BASE_URL:

```bash
SEARXNG_BASE_URL=http://yourdomain.com/searxng/
```

## Documentation

- **SearXNG**: https://docs.searxng.org/
- **Search API**: https://docs.searxng.org/dev/search_api.html

---

**Service Type:** Utility (Metasearch Engine)
**Category:** utilities
**Deployment:** Uses official SearXNG image

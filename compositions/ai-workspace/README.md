# AI Workspace

Complete AI workspace with Open WebUI, Ollama, SearXNG, and Apache Tika behind nginx reverse proxy with path-based routing.

## Overview

AI Workspace provides a unified interface for AI development and document processing. All services are accessible through a single nginx reverse proxy using path-based routing, making it easy to deploy behind firewalls or in containerized environments.

## Services Overview

| Service | Purpose | Internal Port | External Path | Web UI | Dependencies |
|:--------|:--------|:--------------|:--------------|:-------|:-------------|
| Nginx | Reverse proxy with path-based routing | 80 | / | http://localhost/ | All services |
| Open WebUI | Web interface for LLM interaction | 3000 | / | http://localhost/ | Ollama |
| Ollama | LLM inference engine | 11434 | /ollama/ | - | - |
| SearXNG | Privacy-respecting metasearch engine | 8080 | /searxng/ | http://localhost/searxng/ | - |
| Apache Tika | Document text extraction and parsing | 9998 | /tika/ | - | - |

## Architecture

### Deployment Diagram

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Deployment.puml

title Deployment Diagram - AI Workspace Composition

Deployment_Node(docker_host, "Docker Host", "Linux Server") {

    Deployment_Node(nginx_container, "Nginx Container") {
        Container(nginx, "Nginx Reverse Proxy", "nginx:alpine", "Path-based routing for all services")
    }

    Deployment_Node(openwebui_container, "Open WebUI Container") {
        Container(openwebui, "Open WebUI", "ghcr.io/open-webui/open-webui", "Web interface for LLMs")
        ContainerDb(openwebui_data, "Open WebUI Data", "Docker Volume", "User data and settings")
    }

    Deployment_Node(ollama_container, "Ollama Container") {
        Container(ollama, "Ollama", "ollama/ollama", "LLM inference engine")
        ContainerDb(ollama_models, "Model Storage", "Docker Volume", "Downloaded LLM models")
    }

    Deployment_Node(searxng_container, "SearXNG Container") {
        Container(searxng, "SearXNG", "searxng/searxng", "Privacy-respecting search")
        ContainerDb(searxng_config, "SearXNG Config", "Docker Volume", "Search engine settings")
    }

    Deployment_Node(tika_container, "Apache Tika Container") {
        Container(tika, "Apache Tika", "apache/tika", "Document text extraction")
    }
}

Deployment_Node(client, "Client", "Web Browser") {
    Container(browser, "Browser", "Chrome/Firefox", "User interface")
}

Rel(browser, nginx, "HTTP Requests", "80")
Rel(nginx, openwebui, "Proxy /", "3000")
Rel(nginx, ollama, "Proxy /ollama/", "11434")
Rel(nginx, searxng, "Proxy /searxng/", "8080")
Rel(nginx, tika, "Proxy /tika/", "9998")
Rel(openwebui, ollama, "LLM API", "11434")
Rel(openwebui, openwebui_data, "Stores")
Rel(ollama, ollama_models, "Stores")
Rel(searxng, searxng_config, "Stores")

@enduml
```

### Network Diagram

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Network Diagram - AI Workspace Path-Based Routing

Person(user, "User", "Developer or AI enthusiast")

System_Boundary(ai_workspace, "AI Workspace") {
    Container(nginx, "Nginx Reverse Proxy", "nginx:alpine", "Routes requests based on URL path")

    Container(openwebui, "Open WebUI", "ghcr.io/open-webui/open-webui", "Web UI for LLM interaction")
    Container(ollama, "Ollama", "ollama/ollama", "Runs LLM models locally")
    Container(searxng, "SearXNG", "searxng/searxng", "Metasearch engine")
    Container(tika, "Apache Tika", "apache/tika", "Extracts text from documents")

    ContainerDb(openwebui_db, "User Data", "Volume", "Settings and conversations")
    ContainerDb(ollama_db, "Model Storage", "Volume", "LLM models")
    ContainerDb(searxng_db, "Config", "Volume", "Search settings")
}

Rel(user, nginx, "http://localhost/", "HTTP")

Rel(nginx, openwebui, "/ → :3000", "HTTP")
Rel(nginx, ollama, "/ollama/ → :11434", "HTTP")
Rel(nginx, searxng, "/searxng/ → :8080", "HTTP")
Rel(nginx, tika, "/tika/ → :9998", "HTTP")

Rel(openwebui, ollama, "LLM inference", "HTTP")
Rel(openwebui, openwebui_db, "Reads/Writes", "")
Rel(ollama, ollama_db, "Reads/Writes", "")
Rel(searxng, searxng_db, "Reads/Writes", "")

@enduml
```

## Quick Start

### Docker Compose (Development)

```bash
cd compositions/ai-workspace
./scripts/deploy-compose.sh

# Access at http://localhost/
```

### Docker Swarm (Production)

```bash
cd compositions/ai-workspace
./scripts/deploy-swarm.sh

# Check status
docker stack services ai-workspace
```

### Kubernetes/Helm

```bash
cd compositions/ai-workspace

# Development
./scripts/deploy-helm.sh ai-workspace dev

# Production
./scripts/deploy-helm.sh ai-workspace prod
```

## Quick Reference Card

### Access Points

| Service | URL | Purpose |
|:--------|:----|:--------|
| Open WebUI | http://localhost/ | LLM chat interface (main portal) |
| Ollama API | http://localhost/ollama/ | LLM inference API |
| SearXNG | http://localhost/searxng/ | Web search interface |
| Apache Tika | http://localhost/tika/ | Document parsing API |
| Health Check | http://localhost/health | Nginx health endpoint |

### Default Credentials

- **Open WebUI**: Create account on first access
- **SearXNG**: No authentication required
- **Ollama**: No authentication
- **Apache Tika**: No authentication

### Health Checks

```bash
# Nginx health
curl http://localhost/health

# Open WebUI
curl http://localhost/

# Ollama (list models)
curl http://localhost/ollama/api/tags

# SearXNG
curl http://localhost/searxng/

# Apache Tika (version)
curl http://localhost/tika/version
```

### Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| open-webui-data | /app/backend/data | User data and conversations | 1-5GB |
| ollama-data | /root/.ollama | Downloaded LLM models | 50-200GB |
| searxng-data | /etc/searxng | Search engine configuration | <100MB |

### Resource Requirements

**Minimum (Docker Compose):**
- CPU: 4 cores
- RAM: 16GB
- Disk: 100GB (for models)
- GPU: Optional (but recommended for Ollama)

**Recommended (Production):**
- CPU: 8+ cores
- RAM: 32GB+
- Disk: 500GB SSD
- GPU: NVIDIA with 8GB+ VRAM

## Configuration

### Environment Variables

Edit `.env` file or copy from `.env.template`:

```bash
# Nginx Configuration
NGINX_VERSION=alpine
NGINX_PORT=80
NGINX_SERVER_NAME=localhost

# Open WebUI Configuration
OPENWEBUI_VERSION=main
OPENWEBUI_PORT=3000

# Ollama Configuration
OLLAMA_VERSION=latest
OLLAMA_PORT=11434

# SearXNG Configuration
SEARXNG_VERSION=latest
SEARXNG_PORT=8080
SEARXNG_SECRET=ultrasecretkey  # CHANGE THIS!

# Apache Tika Configuration
TIKA_VERSION=latest-full
TIKA_PORT=9998
```

**Important:** Change `SEARXNG_SECRET` before deploying to production!

### Nginx Path-Based Routing

The nginx reverse proxy routes requests based on URL paths:

- `http://localhost/` → Open WebUI (port 3000)
- `http://localhost/ollama/` → Ollama API (port 11434)
- `http://localhost/searxng/` → SearXNG (port 8080)
- `http://localhost/tika/` → Apache Tika (port 9998)

This allows all services to be accessed through a single endpoint, making it easy to:
- Deploy behind corporate firewalls
- Use with reverse proxies (Traefik, nginx, Apache)
- Secure with single TLS certificate
- Access from Kubernetes Ingress

## Usage Examples

### Open WebUI - Chat with LLM

1. Access http://localhost/
2. Create an account (stored locally)
3. Pull a model from Ollama:
   ```bash
   curl -X POST http://localhost/ollama/api/pull -d '{"name":"llama2"}'
   ```
4. Start chatting!

### Ollama API - Direct LLM Access

```bash
# List available models
curl http://localhost/ollama/api/tags

# Pull a model
curl -X POST http://localhost/ollama/api/pull \
  -d '{"name":"llama2"}'

# Generate text
curl -X POST http://localhost/ollama/api/generate \
  -d '{
    "model": "llama2",
    "prompt": "Why is the sky blue?"
  }'
```

### SearXNG - Privacy-Respecting Search

```bash
# Web search
curl "http://localhost/searxng/search?q=docker%20containers&format=json"

# Category-specific search
curl "http://localhost/searxng/search?q=python&format=json&categories=it"
```

### Apache Tika - Document Text Extraction

```bash
# Extract text from PDF
curl -X PUT http://localhost/tika/ \
  -H "Accept: text/plain" \
  --data-binary @document.pdf

# Get document metadata
curl -X PUT http://localhost/tika/meta \
  -H "Accept: application/json" \
  --data-binary @document.pdf

# Detect file type
curl -X PUT http://localhost/tika/detect/stream \
  --data-binary @document.pdf
```

### Integration Example - RAG Pipeline

```python
import requests

# 1. Extract text from document using Tika
with open('document.pdf', 'rb') as f:
    text = requests.put(
        'http://localhost/tika/',
        data=f,
        headers={'Accept': 'text/plain'}
    ).text

# 2. Search for related information using SearXNG
search_results = requests.get(
    'http://localhost/searxng/search',
    params={
        'q': 'related topic',
        'format': 'json'
    }
).json()

# 3. Send to Ollama for analysis
prompt = f"Analyze this document: {text}\n\nRelated info: {search_results}"
response = requests.post(
    'http://localhost/ollama/api/generate',
    json={
        'model': 'llama2',
        'prompt': prompt
    }
)

print(response.json()['response'])
```

## Behind Reverse Proxy

### Nginx (External)

```nginx
location /ai/ {
    proxy_pass http://localhost/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

    # WebSocket support for Open WebUI
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
}
```

### Traefik

```yaml
http:
  routers:
    ai-workspace:
      rule: "PathPrefix(`/ai`)"
      service: ai-workspace
      middlewares:
        - ai-strip-prefix

  services:
    ai-workspace:
      loadBalancer:
        servers:
          - url: "http://localhost:80"

  middlewares:
    ai-strip-prefix:
      stripPrefix:
        prefixes:
          - "/ai"
```

## Deployment Platforms

### Docker Compose

**Use for:** Development, single-host deployments

**Features:**
- Simple deployment with `docker compose up`
- Uses extends pattern to reference service definitions
- Automatic network creation
- Named volumes for persistence

**Deploy:**
```bash
./scripts/deploy-compose.sh
```

### Docker Swarm

**Use for:** Production, multi-host clusters

**Features:**
- Service replicas with load balancing
- Overlay networking across hosts
- Resource limits and reservations
- Rolling updates
- GPU scheduling with node constraints

**Deploy:**
```bash
# Initialize Swarm (if needed)
docker swarm init

# Label GPU nodes
docker node update --label-add gpu=true <node-id>

# Deploy stack
./scripts/deploy-swarm.sh
```

**Configuration:**
- Nginx: 2 replicas, 256MB limit
- Open WebUI: 2 replicas, 2GB limit
- Ollama: 1 replica, GPU required, 16GB limit
- SearXNG: 2 replicas, 512MB limit
- Apache Tika: 2 replicas, 4GB limit

### Kubernetes/Helm

**Use for:** Cloud-native, enterprise deployments

**Features:**
- Helm chart with templated deployments
- Environment-specific values (dev, prod)
- Persistent volume claims
- Ingress support with TLS
- Resource requests and limits
- GPU node selection

**Deploy:**
```bash
# Development
./scripts/deploy-helm.sh ai-workspace dev

# Production
./scripts/deploy-helm.sh ai-workspace prod
```

**Helm Values:**

- `values.yaml` - Default configuration
- `values-dev.yaml` - Development overrides (lower resources)
- `values-prod.yaml` - Production overrides (ingress, TLS, replicas)

**Customize:**
```bash
helm upgrade --install ai-workspace ./helm \
  --namespace ai-workspace \
  --values ./helm/values.yaml \
  --values ./helm/values-prod.yaml \
  --set nginx.ingress.hosts[0].host=ai.yourdomain.com \
  --set searxng.env.secret=your-secret-key
```

## Troubleshooting

### Ollama Models Not Loading

```bash
# Pull models manually
docker exec -it <ollama-container> ollama pull llama2

# Or via API
curl -X POST http://localhost/ollama/api/pull -d '{"name":"llama2"}'
```

### Open WebUI Can't Connect to Ollama

Check the OLLAMA_BASE_URL environment variable:

```bash
# Docker Compose
# Edit docker-compose.yml, ensure:
# environment:
#   - OLLAMA_BASE_URL=http://ollama:11434

# Kubernetes
# Edit helm/values.yaml:
# openwebui:
#   env:
#     ollamaBaseUrl: "http://ai-workspace-ollama:11434"
```

### SearXNG Not Working Behind Proxy

Update SEARXNG_BASE_URL:

```bash
# .env file
SEARXNG_BASE_URL=http://yourdomain.com/searxng/
```

### Nginx 502 Bad Gateway

Services may not be ready. Check service status:

```bash
# Docker Compose
docker compose ps
docker compose logs <service>

# Docker Swarm
docker stack services ai-workspace
docker service logs ai-workspace_<service>

# Kubernetes
kubectl get pods -n ai-workspace
kubectl logs -n ai-workspace <pod-name>
```

### GPU Not Detected in Kubernetes

Ensure NVIDIA device plugin is installed:

```bash
kubectl apply -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/master/nvidia-device-plugin.yml

# Verify
kubectl get nodes -o json | jq '.items[].status.allocatable."nvidia.com/gpu"'
```

## Security Considerations

1. **Change Default Secrets**
   - Update `SEARXNG_SECRET` in `.env`

2. **Network Isolation**
   - Services communicate on internal Docker network
   - Only nginx port (80) exposed externally

3. **Authentication**
   - Add authentication to nginx for production deployments
   - Consider OAuth2 proxy or basic auth

4. **TLS/HTTPS**
   - Use Kubernetes Ingress with cert-manager for TLS
   - Or place behind external reverse proxy with TLS

5. **Resource Limits**
   - Swarm and Kubernetes configs include resource limits
   - Prevents resource exhaustion

## Performance Tuning

### Ollama

```bash
# Increase model cache
docker run -e OLLAMA_MAX_LOADED_MODELS=3 ...

# Use GPU
# Ensure nvidia-docker runtime is configured
```

### Nginx

```nginx
# Increase worker processes (in nginx.conf)
worker_processes auto;
worker_connections 2048;

# Enable caching
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=cache:10m;
```

### Open WebUI

```bash
# Increase replicas in Swarm/Kubernetes
# Docker Swarm
docker service scale ai-workspace_open-webui=4

# Kubernetes
kubectl scale deployment ai-workspace-openwebui --replicas=4 -n ai-workspace
```

## Monitoring

### Docker Compose

```bash
# View logs
docker compose logs -f

# Service-specific logs
docker compose logs -f open-webui

# Resource usage
docker stats
```

### Docker Swarm

```bash
# Service status
docker stack services ai-workspace

# Service logs
docker service logs -f ai-workspace_open-webui

# Node resource usage
docker node ls
docker node inspect <node-id>
```

### Kubernetes

```bash
# Pod status
kubectl get pods -n ai-workspace

# Logs
kubectl logs -f -n ai-workspace deployment/ai-workspace-openwebui

# Resource usage
kubectl top pods -n ai-workspace
kubectl top nodes
```

## Documentation

- **Open WebUI**: https://docs.openwebui.com/
- **Ollama**: https://github.com/ollama/ollama/blob/main/README.md
- **SearXNG**: https://docs.searxng.org/
- **Apache Tika**: https://tika.apache.org/
- **Nginx**: https://nginx.org/en/docs/

---

**Composition Type:** AI Workspace
**Services:** 5 (nginx, open-webui, ollama, searxng, apache-tika)
**Deployment Platforms:** Docker Compose, Docker Swarm, Kubernetes/Helm
**GPU Support:** Yes (Ollama)
**Networking:** Path-based routing via nginx reverse proxy

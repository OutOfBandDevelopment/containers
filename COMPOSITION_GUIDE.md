# Composition Guide

Guide for creating higher-level compositions that combine multiple services into complete stacks.

## Overview

Compositions combine self-contained services into functional application stacks. Each composition should support multiple deployment targets:
- Docker Compose (development)
- Docker Swarm (production clustering)
- Kubernetes with Helm Charts (cloud-native orchestration)

## Composition Structure

```
compositions/
├── [composition-name]/
│   ├── README.md                    # Documentation with PlantUML diagrams
│   ├── docker-compose.yml           # Docker Compose deployment
│   ├── docker-compose.swarm.yml     # Docker Swarm stack file
│   ├── .env.template                # Environment configuration
│   ├── helm/                        # Kubernetes Helm chart
│   │   ├── Chart.yaml
│   │   ├── values.yaml
│   │   ├── values-dev.yaml
│   │   ├── values-prod.yaml
│   │   └── templates/
│   │       ├── deployment.yaml
│   │       ├── service.yaml
│   │       ├── configmap.yaml
│   │       └── secrets.yaml
│   ├── scripts/
│   │   ├── deploy-compose.sh/.bat   # Docker Compose deployment
│   │   ├── deploy-swarm.sh/.bat     # Docker Swarm deployment
│   │   └── deploy-helm.sh/.bat      # Kubernetes/Helm deployment
│   └── docs/
│       ├── deployment-diagram.puml  # PlantUML deployment diagram
│       └── network-diagram.puml     # PlantUML network diagram
```

## README Documentation Requirements

Each composition README must include:

### 1. Services Overview Table

A comprehensive table listing all services in the composition:

```markdown
## Services Overview

| Service | Purpose | Internal Port | External Port | Web UI | Dependencies |
|:--------|:--------|:--------------|:--------------|:-------|:-------------|
| Ollama | LLM inference engine | 11434 | 11434 | - | - |
| Qdrant | Vector database for embeddings | 6333, 6334 | 6333, 6334 | http://localhost:6333/dashboard | - |
| SBERT | Sentence embedding service | 8080 | 8080 | - | - |
| Open WebUI | Web interface for LLM interaction | 3000 | 3000 | http://localhost:3000 | Ollama |
| PostgreSQL | Metadata storage | 5432 | 5432 | - | - |
| OpenSearch | Full-text search and analytics | 9200, 9600 | 9200 | - | - |
| OpenSearch Dashboards | Visualization for OpenSearch | 5601 | 5601 | http://localhost:5601 | OpenSearch |
```

### 2. Quick Reference Card

Essential information for using the composition:

```markdown
## Quick Reference

### Access Points
- **Open WebUI**: http://localhost:3000
- **Qdrant Dashboard**: http://localhost:6333/dashboard
- **OpenSearch Dashboards**: http://localhost:5601
- **Ollama API**: http://localhost:11434

### Default Credentials
- **PostgreSQL**:
  - User: `admin`
  - Password: `changeme` (set in .env)
- **OpenSearch**:
  - User: `admin`
  - Password: `admin` (set in .env)

### Health Check Endpoints
- Ollama: http://localhost:11434/api/tags
- Qdrant: http://localhost:6333/healthz
- SBERT: http://localhost:8080/health
- OpenSearch: http://localhost:9200/_cluster/health

### Persistent Volumes
- `ollama-data`: LLM models and configuration (~50GB)
- `qdrant-storage`: Vector embeddings (~20GB)
- `qdrant-snapshots`: Backup snapshots (~5GB)
- `postgres-data`: Metadata database (~1GB)
- `opensearch-data`: Search indices (~10GB)

### Resource Requirements
- **Minimum**: 8GB RAM, 4 CPU cores
- **Recommended**: 16GB RAM, 8 CPU cores, GPU (for Ollama)
- **Storage**: 100GB free space
```

### 3. PlantUML Deployment Diagram

Shows how services are deployed across nodes/pods:

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Deployment.puml

title Deployment Diagram - Full AI/ML Stack

Deployment_Node(docker_host, "Docker Host", "Linux Server") {
    Deployment_Node(ollama_container, "Ollama Container") {
        Container(ollama, "Ollama", "LLM Runtime", "Runs language models")
    }

    Deployment_Node(qdrant_container, "Qdrant Container") {
        ContainerDb(qdrant, "Qdrant", "Vector Database", "Stores embeddings")
    }

    Deployment_Node(sbert_container, "SBERT Container") {
        Container(sbert, "SBERT", "Embedding Service", "Generates embeddings")
    }

    Deployment_Node(webui_container, "Open WebUI Container") {
        Container(webui, "Open WebUI", "Web Interface", "User interface")
    }
}

Rel(webui, ollama, "Queries", "HTTP/REST")
Rel(ollama, qdrant, "Retrieves context", "gRPC")
Rel(sbert, qdrant, "Stores embeddings", "gRPC")

@enduml
```

### 2. PlantUML Network Diagram

Shows network topology and communication paths:

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Network Diagram - Full AI/ML Stack

Person(user, "User", "End user accessing the system")

System_Boundary(composition, "AI/ML Stack") {
    Container(webui, "Open WebUI", "React", "Web interface for LLM interaction")
    Container(ollama, "Ollama", "Go", "LLM inference engine")
    Container(sbert, "SBERT", "Python", "Sentence embeddings service")
    ContainerDb(qdrant, "Qdrant", "Vector DB", "Vector similarity search")
    ContainerDb(postgres, "PostgreSQL", "Database", "Metadata storage")
}

Rel(user, webui, "Uses", "HTTPS:3000")
Rel(webui, ollama, "Generate text", "HTTP:11434")
Rel(webui, sbert, "Generate embeddings", "HTTP:8080")
Rel(ollama, qdrant, "RAG context", "gRPC:6334")
Rel(sbert, qdrant, "Store vectors", "gRPC:6334")
Rel(webui, postgres, "Store metadata", "PostgreSQL:5432")

@enduml
```

### 3. Deployment Instructions

For each deployment target:

**Docker Compose:**
```bash
cd compositions/full-ai-ml-stack
cp .env.template .env
# Edit .env
./scripts/deploy-compose.sh
```

**Docker Swarm:**
```bash
# Initialize swarm (if not already)
docker swarm init

# Deploy stack
./scripts/deploy-swarm.sh
```

**Kubernetes with Helm:**
```bash
# Add any required repositories
helm repo add bitnami https://charts.bitnami.com/bitnami

# Deploy to development
./scripts/deploy-helm.sh dev

# Deploy to production
./scripts/deploy-helm.sh prod
```

## Docker Compose Format

Use `extends` to reference individual services:

```yaml
services:
  ollama:
    extends:
      file: ../../services/ai-ml/ollama/docker-compose.yml
      service: ollama
    networks:
      - ai-ml-network

  qdrant:
    extends:
      file: ../../services/databases/qdrant/docker-compose.yml
      service: qdrant
    networks:
      - ai-ml-network

networks:
  ai-ml-network:
    driver: bridge
```

## Docker Swarm Format

Create `docker-compose.swarm.yml` with deployment configurations:

```yaml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    deploy:
      replicas: 2
      placement:
        constraints:
          - node.labels.gpu == true
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
      update_config:
        parallelism: 1
        delay: 10s
    networks:
      - ai-ml-network
    volumes:
      - ollama-data:/root/.ollama

  qdrant:
    image: qdrant/qdrant:latest
    deploy:
      replicas: 3
      placement:
        constraints:
          - node.labels.storage == ssd
    networks:
      - ai-ml-network
    volumes:
      - qdrant-data:/qdrant/storage

networks:
  ai-ml-network:
    driver: overlay
    attachable: true

volumes:
  ollama-data:
    driver: local
  qdrant-data:
    driver: local
```

**Deploy to swarm:**
```bash
docker stack deploy -c docker-compose.swarm.yml ai-ml-stack
```

## Helm Chart Structure

### Chart.yaml

```yaml
apiVersion: v2
name: full-ai-ml-stack
description: Complete AI/ML stack with Ollama, Qdrant, SBERT, and Open WebUI
type: application
version: 1.0.0
appVersion: "1.0"

dependencies:
  - name: postgresql
    version: 12.x.x
    repository: https://charts.bitnami.com/bitnami
    condition: postgresql.enabled
```

### values.yaml (defaults)

```yaml
# Global settings
global:
  storageClass: "standard"

# Ollama configuration
ollama:
  enabled: true
  replicaCount: 1
  image:
    repository: ollama/ollama
    tag: latest
    pullPolicy: IfNotPresent

  service:
    type: ClusterIP
    port: 11434

  resources:
    limits:
      nvidia.com/gpu: 1
      memory: 8Gi
    requests:
      memory: 4Gi

  persistence:
    enabled: true
    size: 50Gi

# Qdrant configuration
qdrant:
  enabled: true
  replicaCount: 1
  image:
    repository: qdrant/qdrant
    tag: latest

  service:
    type: ClusterIP
    httpPort: 6333
    grpcPort: 6334

  persistence:
    enabled: true
    size: 20Gi
```

### values-dev.yaml

```yaml
# Development overrides
ollama:
  replicaCount: 1
  resources:
    limits:
      memory: 4Gi
    requests:
      memory: 2Gi

qdrant:
  replicaCount: 1
  persistence:
    size: 10Gi
```

### values-prod.yaml

```yaml
# Production overrides
ollama:
  replicaCount: 3
  resources:
    limits:
      nvidia.com/gpu: 1
      memory: 16Gi
    requests:
      memory: 8Gi

qdrant:
  replicaCount: 3
  persistence:
    size: 100Gi
    storageClass: "fast-ssd"
```

### templates/deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "fullname" . }}-ollama
  labels:
    {{- include "labels" . | nindent 4 }}
    app.kubernetes.io/component: ollama
spec:
  replicas: {{ .Values.ollama.replicaCount }}
  selector:
    matchLabels:
      {{- include "selectorLabels" . | nindent 6 }}
      app.kubernetes.io/component: ollama
  template:
    metadata:
      labels:
        {{- include "selectorLabels" . | nindent 8 }}
        app.kubernetes.io/component: ollama
    spec:
      containers:
      - name: ollama
        image: "{{ .Values.ollama.image.repository }}:{{ .Values.ollama.image.tag }}"
        imagePullPolicy: {{ .Values.ollama.image.pullPolicy }}
        ports:
        - name: http
          containerPort: 11434
          protocol: TCP
        resources:
          {{- toYaml .Values.ollama.resources | nindent 12 }}
        volumeMounts:
        - name: data
          mountPath: /root/.ollama
      volumes:
      - name: data
        {{- if .Values.ollama.persistence.enabled }}
        persistentVolumeClaim:
          claimName: {{ include "fullname" . }}-ollama
        {{- else }}
        emptyDir: {}
        {{- end }}
```

## Deployment Scripts

### deploy-compose.sh

```bash
#!/bin/bash
set -e

echo "Deploying with Docker Compose..."

# Check prerequisites
if [ ! -f .env ]; then
    echo "Creating .env from template..."
    cp .env.template .env
    echo "Please edit .env and run again"
    exit 1
fi

# Deploy
docker compose up -d

echo "Deployment complete!"
echo "Services:"
docker compose ps
```

### deploy-swarm.sh

```bash
#!/bin/bash
set -e

echo "Deploying to Docker Swarm..."

# Check if swarm is initialized
if ! docker info | grep -q "Swarm: active"; then
    echo "Docker Swarm not initialized. Run: docker swarm init"
    exit 1
fi

# Deploy stack
docker stack deploy -c docker-compose.swarm.yml ai-ml-stack

echo "Stack deployed!"
echo "Services:"
docker stack services ai-ml-stack
```

### deploy-helm.sh

```bash
#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
NAMESPACE=${2:-ai-ml}

echo "Deploying to Kubernetes (${ENVIRONMENT})..."

# Create namespace if not exists
kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

# Deploy with Helm
helm upgrade --install \
  ai-ml-stack \
  ./helm \
  --namespace ${NAMESPACE} \
  --values ./helm/values-${ENVIRONMENT}.yaml \
  --wait

echo "Deployment complete!"
kubectl get pods -n ${NAMESPACE}
```

## Best Practices

### Resource Limits

Always define resource limits for production:

```yaml
resources:
  limits:
    cpu: "2"
    memory: 4Gi
  requests:
    cpu: "1"
    memory: 2Gi
```

### Health Checks

Include health checks in all deployments:

```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
```

### Secrets Management

Use proper secrets management:

**Docker Swarm:**
```bash
echo "mysecretpassword" | docker secret create db_password -
```

**Kubernetes:**
```bash
kubectl create secret generic db-credentials \
  --from-literal=password=mysecretpassword
```

### Network Policies

Define network policies for security:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
spec:
  podSelector:
    matchLabels:
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          tier: frontend
```

## Testing Compositions

Before deploying to production:

1. **Test locally with Docker Compose**
2. **Test in dev cluster (Swarm or Kubernetes)**
3. **Load test critical paths**
4. **Verify backup/restore procedures**
5. **Document rollback procedures**

## Example Compositions

Planned compositions:

1. **full-ai-ml-stack**: Complete AI/ML environment (Ollama, Qdrant, SBERT, OpenSearch, Open WebUI)
2. **vector-search-rag**: RAG pipeline (Ollama, Qdrant, SBERT)
3. **data-science**: Analytics environment (Jupyter, MongoDB, ParadeDB, visualization)
4. **microservices-dev**: Development stack (Kafka, RabbitMQ, Keycloak, databases)
5. **observability-stack**: Monitoring (Prometheus, Grafana, Loki, Tempo)

---

*Created: 2026-01-09*
*Version: 1.0*

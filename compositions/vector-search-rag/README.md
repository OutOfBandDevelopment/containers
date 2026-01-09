# Vector Search RAG Composition

Complete vector search and Retrieval-Augmented Generation (RAG) stack combining Ollama LLM, Qdrant vector database, and SBERT embeddings service.

## Overview

This composition provides a production-ready RAG infrastructure for AI applications requiring semantic search and context-aware text generation. Perfect for building chatbots, question-answering systems, document search, and knowledge retrieval applications.

The stack combines three powerful services that work together to enable semantic search and contextual text generation.

## Services Overview

| Service | Purpose | Internal Port | External Port | Web UI | Dependencies |
|:--------|:--------|:--------------|:--------------|:-------|:-------------|
| Ollama | LLM inference engine | 11434 | 11434 | - | - |
| Qdrant | Vector database for embeddings | 6333, 6334 | 6333, 6334 | http://localhost:6333/dashboard | - |
| SBERT | Sentence embedding service | 8080 | 8080 | - | Qdrant |

## Quick Reference

### Access Points
- **Ollama API**: http://localhost:11434
- **Qdrant Dashboard**: http://localhost:6333/dashboard
- **Qdrant API**: http://localhost:6333
- **SBERT API**: http://localhost:8080

### Health Check Endpoints
- Ollama: `http://localhost:11434/api/tags`
- Qdrant: `http://localhost:6333/healthz`
- SBERT: `http://localhost:8080/health`

### Persistent Volumes
- `ollama-data`: LLM models and configuration (~50GB)
- `qdrant-storage`: Vector embeddings (~20GB)
- `qdrant-snapshots`: Backup snapshots (~5GB)

### Resource Requirements
- **Minimum**: 8GB RAM, 4 CPU cores
- **Recommended**: 16GB RAM, 8 CPU cores, NVIDIA GPU (for Ollama)
- **Storage**: 80GB free space

## Architecture Diagrams

### Deployment Diagram

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Deployment.puml

title Deployment Diagram - Vector Search RAG Composition

Deployment_Node(docker_host, "Docker Host", "Linux Server") {
    Deployment_Node(ollama_container, "Ollama Container") {
        Container(ollama, "Ollama", "LLM Runtime", "Runs language models for text generation")
    }

    Deployment_Node(qdrant_container, "Qdrant Container") {
        ContainerDb(qdrant, "Qdrant", "Vector Database", "Stores and searches embeddings")
    }

    Deployment_Node(sbert_container, "SBERT Container") {
        Container(sbert, "SBERT", "Embedding Service", "Generates sentence embeddings")
    }
}

Rel(ollama, qdrant, "Retrieves context", "gRPC:6334")
Rel(sbert, qdrant, "Stores embeddings", "HTTP:6333")

@enduml
```

### Network Diagram

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Network Diagram - Vector Search RAG Composition

Person(user, "Application", "RAG application using the stack")

System_Boundary(rag, "Vector Search RAG Stack") {
    Container(ollama, "Ollama", "LLM Runtime", "Text generation and completion")
    Container(sbert, "SBERT", "Python/Flask", "Sentence embedding generation")
    ContainerDb(qdrant, "Qdrant", "Vector DB", "Semantic search and retrieval")
}

Rel(user, ollama, "Generate text", "HTTP:11434")
Rel(user, sbert, "Generate embeddings", "HTTP:8080")
Rel(user, qdrant, "Search vectors", "HTTP:6333")
Rel(ollama, qdrant, "RAG context retrieval", "gRPC:6334")
Rel(sbert, qdrant, "Store embeddings", "HTTP:6333")

@enduml
```

## Deployment Options

### Docker Compose (Development)

```bash
cd compositions/vector-search-rag
cp .env.template .env
./scripts/deploy-compose.sh
```

### Docker Swarm (Production Clustering)

```bash
# Initialize swarm (if not already)
docker swarm init

# Deploy stack
./scripts/deploy-swarm.sh
```

### Kubernetes with Helm (Cloud-Native)

```bash
# Development deployment
./scripts/deploy-helm.sh dev

# Production deployment
./scripts/deploy-helm.sh prod
```

## Usage Examples

### Store and Search Documents

```python
import requests
from sentence_transformers import SentenceTransformer

# Generate embedding with SBERT
response = requests.post('http://localhost:8080/embed',
    json={'text': 'How does photosynthesis work?'})
embedding = response.json()['embedding']

# Store in Qdrant
requests.put('http://localhost:6333/collections/docs/points', json={
    'points': [{
        'id': 1,
        'vector': embedding,
        'payload': {'text': 'Photosynthesis is the process...'}
    }]
})

# Search similar documents
response = requests.post('http://localhost:6333/collections/docs/points/search', json={
    'vector': embedding,
    'limit': 5
})
results = response.json()['result']
```

### RAG with Ollama

```python
# Get relevant context from Qdrant
query_embedding = requests.post('http://localhost:8080/embed',
    json={'text': 'What is photosynthesis?'}).json()['embedding']

context_docs = requests.post('http://localhost:6333/collections/docs/points/search', json={
    'vector': query_embedding,
    'limit': 3
}).json()['result']

# Build context
context = '\n'.join([doc['payload']['text'] for doc in context_docs])

# Generate answer with Ollama
response = requests.post('http://localhost:11434/api/generate', json={
    'model': 'llama2',
    'prompt': f'Context: {context}\n\nQuestion: What is photosynthesis?\n\nAnswer:'
})
```

## Configuration

Edit `.env` to customize:

```bash
# Ollama Configuration
OLLAMA_PORT=11434

# Qdrant Configuration
QDRANT_HTTP_PORT=6333
QDRANT_GRPC_PORT=6334

# SBERT Configuration
SBERT_PORT=8080
SBERT_MODEL=all-MiniLM-L6-v2
```

## Scaling

### Docker Swarm
Edit `docker-compose.swarm.yml` to adjust replicas:
```yaml
deploy:
  replicas: 3  # Scale to 3 instances
```

### Kubernetes/Helm
Edit `helm/values-prod.yaml`:
```yaml
qdrant:
  replicaCount: 5  # Scale Qdrant to 5 pods
```

## Monitoring

Check service status:
```bash
# Docker Compose
docker compose ps

# Docker Swarm
docker stack services vector-search-rag

# Kubernetes
kubectl get pods -n ai-ml
```

## Troubleshooting

**Ollama can't connect to Qdrant:**
- Check network: `docker network ls`
- Verify Qdrant is running: `curl http://localhost:6333/healthz`

**SBERT failing to start:**
- Check logs: `docker compose logs sbert`
- Verify model is valid in .env

**Out of memory:**
- Reduce Qdrant collection size
- Use smaller Ollama models
- Increase Docker/Kubernetes resource limits

## Documentation

- **Ollama**: https://ollama.ai/
- **Qdrant**: https://qdrant.tech/documentation/
- **SBERT**: https://www.sbert.net/

---

**Composition Type:** AI/ML Stack (RAG)
**Services:** 3 (Ollama, Qdrant, SBERT)
**Deployment:** Docker Compose, Docker Swarm, Kubernetes/Helm
**GPU Support:** Optional (recommended for Ollama)

# SBERT - Sentence Transformers Service

Sentence embedding API service using Sentence-BERT (SBERT) models. Supports both CPU and GPU acceleration.

## Overview

Provides a REST API for generating sentence embeddings using state-of-the-art Sentence Transformers models. Embeddings are useful for semantic search, clustering, and similarity comparisons.

## Service Type

**Category:** ai-ml
**Variants:** CPU and GPU (CUDA)

## Consolidated Service

This service consolidates multiple SBERT implementations:
- **ContainerStore version** (CPU)
- **RunScripts version** (CPU)
- **RunScripts CUDA version** (GPU)

Now unified with Docker Compose profiles for flexible deployment.

## Quick Start

### CPU Version (Recommended for Development)

**Linux/macOS:**
```bash
cd services/ai-ml/sbert
cp .env.template .env
./build-cpu.sh
./start-cpu.sh
```

**Windows:**
```cmd
cd services\ai-ml\sbert
copy .env.template .env
build-cpu.bat
start-cpu.bat
```

### GPU Version (CUDA - For Production/Performance)

**Prerequisites:**
- NVIDIA GPU
- NVIDIA Container Toolkit installed

**Linux/macOS:**
```bash
cd services/ai-ml/sbert
cp .env.template .env
./build-gpu.sh
./start-gpu.sh
```

**Windows:**
```cmd
cd services\ai-ml\sbert
copy .env.template .env
build-gpu.bat
start-gpu.bat
```

### Using Docker Compose Directly

**CPU:**
```bash
docker compose --profile cpu up -d
```

**GPU:**
```bash
docker compose --profile gpu up -d
```

### As Part of Composition

See compositions:
- `compositions/full-ai-ml-stack/` - Complete AI/ML environment
- `compositions/vector-search-rag/` - RAG pattern with Ollama + Qdrant

## Configuration

### Environment Variables

| Variable | Default | Description |
|:---------|:--------|:------------|
| SBERT_PORT | 8080 | HTTP API port |
| SBERT_MODEL | all-mpnet-base-v2 | Model to use |
| GPU_COUNT | 1 | Number of GPUs (GPU profile only) |
| REGISTRY | local | Docker registry for images |

### Volumes

| Volume | Purpose |
|:-------|:--------|
| sbert-models | HuggingFace model cache |

### Ports

| Port | Service |
|:-----|:--------|
| 8080 | Flask API (configurable via SBERT_PORT) |

## Available Models

Popular Sentence Transformer models:

| Model | Size | Speed | Quality | Use Case |
|:------|:-----|:------|:--------|:---------|
| all-MiniLM-L6-v2 | 80MB | Fast | Good | General purpose, fast |
| all-mpnet-base-v2 | 420MB | Medium | Best | Balanced (recommended) |
| all-MiniLM-L12-v2 | 120MB | Medium | Better | Better quality than L6 |
| paraphrase-multilingual-mpnet-base-v2 | 970MB | Slow | Best | 50+ languages |

See: https://www.sbert.net/docs/pretrained_models.html

## API Usage

### Health Check

```bash
curl http://localhost:8080/health
```

### Generate Single Embedding

```bash
curl "http://localhost:8080/generate-embedding?query=Hello+world"
```

### Generate Multiple Embeddings

```bash
curl -X POST http://localhost:8080/generate-embeddings \
  -H "Content-Type: application/json" \
  -d '["First sentence", "Second sentence"]'
```

### OpenAI-Compatible Format

```bash
curl -X POST http://localhost:8080/v1/embeddings \
  -H "Content-Type: application/json" \
  -d '{
    "input": "Your text here",
    "model": "sentence-transformers/all-mpnet-base-v2"
  }'
```

**Response:**
```json
{
  "data": [{
    "embedding": [0.123, -0.456, ...],
    "index": 0,
    "object": "embedding"
  }],
  "model": "sentence-transformers/all-mpnet-base-v2",
  "object": "list",
  "usage": {
    "prompt_tokens": 3,
    "total_tokens": 3
  }
}
```

## Performance

### CPU vs GPU

| Batch Size | CPU Time | GPU Time | Speedup |
|:-----------|:---------|:---------|:--------|
| 1 sentence | ~50ms | ~20ms | 2.5x |
| 10 sentences | ~300ms | ~30ms | 10x |
| 100 sentences | ~2.5s | ~150ms | 17x |

GPU is recommended for:
- Batch processing
- Real-time applications
- High throughput scenarios

## Management Scripts

### Build Scripts

| Script | Purpose |
|:-------|:--------|
| `build-cpu.sh` / `.bat` | Build CPU image |
| `build-gpu.sh` / `.bat` | Build GPU image |

### Run Scripts

| Script | Purpose |
|:-------|:--------|
| `start-cpu.sh` / `.bat` | Start CPU service |
| `start-gpu.sh` / `.bat` | Start GPU service |
| `stop.sh` / `.bat` | Stop all services |

## Integration Examples

### With Qdrant (Vector Database)

```python
import requests

# Get embedding from SBERT
response = requests.get(
    "http://localhost:8080/generate-embedding",
    params={"query": "Sample text"}
)
embedding = response.json()["embedding"]

# Store in Qdrant
import qdrant_client
client = qdrant_client.QdrantClient("localhost", port=6333)
client.upsert(
    collection_name="my_collection",
    points=[{
        "id": 1,
        "vector": embedding,
        "payload": {"text": "Sample text"}
    }]
)
```

### With Ollama (RAG Pattern)

```python
# 1. Get document embeddings
doc_embedding = requests.get(
    "http://localhost:8080/generate-embedding",
    params={"query": "Document content"}
).json()["embedding"]

# 2. Search similar documents in Qdrant
# 3. Send context + query to Ollama for generation
```

## Composition Examples

This service works well with:

- **compositions/vector-search-rag/** - RAG pattern with Ollama + Qdrant
- **compositions/full-ai-ml-stack/** - Complete AI/ML environment

## Troubleshooting

### GPU Not Detected

```bash
# Verify NVIDIA drivers
nvidia-smi

# Test Docker GPU support
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```

### Model Download Fails

Models are downloaded on first start. If download fails:
```bash
# Clear cache and rebuild
docker volume rm sbert-models
./build-cpu.sh
```

### Out of Memory (GPU)

Reduce batch size or use a smaller model (all-MiniLM-L6-v2).

## Source & Consolidation

**Consolidated from:**
- ContainerStore `DockerFile.sbert` (CPU version)
- RunScripts `DockerFile.sbert` (CPU version)
- RunScripts `DockerFile.sbert-cuda` (GPU version)

**Consolidation date:** 2026-01-09
**Method:** Single Dockerfile with build args, Docker Compose profiles

**Benefits of consolidation:**
- Single service, multiple deployment options
- Consistent API across CPU/GPU
- Shared model cache
- Easier maintenance

---

**Category:** AI/ML
**Type:** Sentence Embeddings Service
**Variants:** CPU, GPU (CUDA)

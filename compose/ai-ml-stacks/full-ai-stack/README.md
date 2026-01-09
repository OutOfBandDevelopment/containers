# Full AI/ML Development Stack

Complete, production-ready AI/ML infrastructure with modular architecture, GPU-aware deployment, and comprehensive service orchestration.

## Overview

This stack provides a complete AI/ML development and production environment with:
- **LLM Inference** (Ollama)
- **Vector Database** (Qdrant)
- **Sentence Embeddings** (SBERT)
- **Full-Text Search** (OpenSearch)
- **Document Processing** (Apache Tika)
- **Authentication** (Keycloak)
- **Message Queuing** (RabbitMQ, Kafka)
- **Multiple Databases** (SQL Server, PostgreSQL/ParadeDB, MongoDB)
- **Cloud Emulators** (Azurite, LocalStack)
- **Development Utilities** (SMTP4Dev, PgAdmin, OpenSearch Dashboards)

## Architecture

### Modular Design

The stack uses Docker Compose `extends` pattern for maximum flexibility:
- **Main Stacks:**
  - `docker-compose-cpu.yml` - Full stack (CPU only)
  - `docker-compose-cuda.yml` - Full stack (GPU-aware with CUDA)

- **Individual Services:** 19 modular compose files, one per service
  - Use independently or compose custom stacks
  - Mix and match services as needed
  - Each service is self-contained and documented

### Network Architecture

- **Frontend Network:** Public-facing services (UIs, dashboards)
- **Backend Network:** Internal services (databases, message queues)
- Services connect to appropriate networks based on access requirements

## Quick Start

### Prerequisites

- Docker 20.10+ with Docker Compose v2
- For GPU version: NVIDIA Container Toolkit
- Minimum 16GB RAM (32GB recommended)
- 50GB free disk space

### Basic Setup (CPU)

1. **Copy environment template:**
   ```bash
   cp .env.template .env
   ```

2. **Edit `.env` file and set passwords:**
   ```bash
   # Change all default passwords!
   KEYCLOAK_ADMIN_PASSWORD=your-secure-password
   MSSQL_SA_PASSWORD=your-secure-password
   POSTGRESQL_PASSWORD=your-secure-password
   # ... (see .env.template for all variables)
   ```

3. **Start the full stack:**
   ```bash
   # Using script
   ./up.sh

   # Or manually
   docker compose -f docker-compose-cpu.yml up -d
   ```

4. **Verify services:**
   ```bash
   docker compose ps
   ```

### GPU-Accelerated Setup (CUDA)

1. **Verify NVIDIA drivers and Container Toolkit installed**
   ```bash
   nvidia-smi
   docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
   ```

2. **Start GPU-aware stack:**
   ```bash
   # Using script
   ./up-cuda.sh

   # Or manually
   docker compose -f docker-compose-cuda.yml up -d
   ```

3. **GPU services:** Ollama and SBERT will use GPU acceleration

## Services & Ports

### AI/ML Services

| Service | Port | Purpose | URL |
|:--------|:-----|:--------|:----|
| **Ollama** | 11434 | LLM Inference | http://localhost:11434 |
| **Qdrant** | 6333 | Vector Database | http://localhost:6333 |
| **SBERT** | 8080 | Sentence Embeddings | http://localhost:8080 |
| **OpenSearch** | 9200 | Full-Text Search | http://localhost:9200 |
| **Apache Tika** | 9998 | Document Processing | http://localhost:9998 |

### Databases

| Service | Port | Purpose | Credentials |
|:--------|:-----|:--------|:------------|
| **SQL Server** | 1433 | Relational DB | sa / $MSSQL_SA_PASSWORD |
| **ParadeDB** | 5432 | PostgreSQL + Extensions | admin / $POSTGRESQL_PASSWORD |
| **MongoDB** | 27017 | Document DB | (no auth in dev) |

### Authentication & Management

| Service | Port | Purpose | URL |
|:--------|:-----|:--------|:----|
| **Keycloak** | 8081 | IAM/SSO | http://localhost:8081 |
| **PgAdmin** | 8082 | PostgreSQL UI | http://localhost:8082 |
| **OpenSearch Dashboards** | 5601 | Search UI | http://localhost:5601 |
| **Open WebUI** | 3000 | LLM Chat Interface | http://localhost:3000 |

### Messaging & Queuing

| Service | Port | Purpose | URL |
|:--------|:-----|:--------|:----|
| **RabbitMQ** | 5672 | AMQP Broker | amqp://localhost:5672 |
| **RabbitMQ Management** | 15672 | Management UI | http://localhost:15672 |
| **Kafka** | 9092 | Event Streaming | localhost:9092 |

### Cloud Emulators

| Service | Port | Purpose |
|:--------|:-----|:--------|
| **Azurite (Blob)** | 10000 | Azure Storage Emulator |
| **Azurite (Queue)** | 10001 | Azure Queue Emulator |
| **Azurite (Table)** | 10002 | Azure Table Emulator |
| **LocalStack** | 4566 | AWS Services Emulator |

### Utilities

| Service | Port | Purpose | URL |
|:--------|:-----|:--------|:----|
| **SMTP4Dev** | 5000 | SMTP Test Server | http://localhost:5000 |

## Usage Examples

### Using Individual Services

Start only the services you need:

```bash
# Just Ollama + Qdrant for vector search
docker compose -f docker-compose.ollama.yml -f docker-compose.qdrant.yml up -d

# Database stack only
docker compose -f docker-compose.paradedb.yml -f docker-compose.pgadmin.yml up -d

# AI/ML core services
docker compose -f docker-compose.ollama.yml \
               -f docker-compose.qdrant.yml \
               -f docker-compose.sbert.yml \
               -f docker-compose.opensearch.yml up -d
```

### Custom Service Combinations

Create your own compose file using `extends`:

```yaml
# my-custom-stack.yml
services:
  qdrant:
    extends:
      file: docker-compose.qdrant.yml
      service: qdrant
    networks:
      - backend

  sbert:
    extends:
      file: docker-compose.sbert.yml
      service: sbert
    networks:
      - backend

networks:
  backend:
    driver: bridge
```

## Management Scripts

### Linux/macOS (Bash)

```bash
./build.sh        # Build all custom images (CPU)
./build-cuda.sh   # Build all custom images (CUDA)
./up.sh           # Start CPU stack
./up-cuda.sh      # Start CUDA stack
./down.sh         # Stop and remove all containers
./stop.sh         # Stop containers (keep data)
```

### Windows (Batch)

```cmd
build.bat         REM Build all custom images (CPU)
build-cuda.bat    REM Build all custom images (CUDA)
up.bat            REM Start CPU stack
up-cuda.bat       REM Start CUDA stack
down.bat          REM Stop and remove all containers
stop.bat          REM Stop containers (keep data)
```

## Data Persistence

All services use named volumes for data persistence:

| Volume | Service | Purpose |
|:-------|:--------|:--------|
| keycloak-data | Keycloak | User and realm data |
| qdrant-storage | Qdrant | Vector embeddings |
| qdrant-snapshots | Qdrant | Backup snapshots |
| opensearch-data | OpenSearch | Search indices |
| sqlserver-data | SQL Server | Database files |
| paradedb-data | ParadeDB | PostgreSQL data |
| mongodb-data | MongoDB | Collections |
| rabbitmq-data | RabbitMQ | Message queues |
| azurite-data | Azurite | Azure storage |
| smtp4dev-data | SMTP4Dev | Test emails |
| kafka-data | Kafka | Event logs |

### Backup Data

```bash
# Backup specific volume
docker run --rm -v qdrant-storage:/data -v $(pwd):/backup alpine tar czf /backup/qdrant-backup.tar.gz /data

# Restore volume
docker run --rm -v qdrant-storage:/data -v $(pwd):/backup alpine tar xzf /backup/qdrant-backup.tar.gz -C /
```

## Configuration

### Environment Variables

All configuration is managed through `.env` file. See `.env.template` for:
- Service ports
- Passwords and credentials
- Database names and users
- GPU settings

### Custom Images

Three custom Docker images with specific configurations:

1. **DockerFile.keycloak** - Keycloak with realm import
2. **DockerFile.ollama** - Ollama with custom models
3. **DockerFile.sbert** - Sentence BERT embedding service

Build custom images:
```bash
docker build -f DockerFile.keycloak -t local/keycloak:latest .
docker build -f DockerFile.ollama -t local/ollama:latest .
docker build -f DockerFile.sbert -t local/sbert:latest .
```

## Security Considerations

### Development vs Production

**This configuration is optimized for development.**

For production:

1. **Change all default passwords**
   - Use strong, unique passwords
   - Consider password managers or secrets management

2. **Enable TLS/SSL**
   - Configure HTTPS for all web interfaces
   - Use proper certificates (not self-signed)

3. **Network isolation**
   - Use Docker networks properly
   - Implement firewall rules
   - Consider service mesh for production

4. **Access controls**
   - Enable authentication on all services
   - Use Keycloak for SSO
   - Implement proper RBAC

5. **Secrets management**
   - Use Docker Secrets or Kubernetes Secrets
   - Consider HashiCorp Vault
   - Never commit `.env` to version control

6. **Monitoring & logging**
   - Add Prometheus + Grafana
   - Centralized logging (ELK stack)
   - Security audit logging

7. **Regular updates**
   - Keep all images updated
   - Security patch regularly
   - Monitor CVE databases

## Troubleshooting

### Common Issues

**Services won't start:**
```bash
# Check logs
docker compose logs [service-name]

# Check resource usage
docker stats

# Verify ports not in use
netstat -an | grep [port]
```

**GPU not detected:**
```bash
# Verify NVIDIA drivers
nvidia-smi

# Test NVIDIA Container Toolkit
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

# Check Docker GPU support
docker run --rm --gpus all ubuntu nvidia-smi
```

**Out of memory:**
```bash
# Increase Docker memory limit (Docker Desktop)
# Settings → Resources → Memory → Increase to 16GB+

# Check current usage
docker stats
```

**Permission errors:**
```bash
# Linux: Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in

# Fix volume permissions
docker compose down
sudo chown -R $USER:$USER ./
```

## Development Workflow

### Typical AI/ML Pipeline

1. **Document Processing:**
   ```bash
   curl -T document.pdf http://localhost:9998/tika --header "Accept: text/plain"
   ```

2. **Generate Embeddings (SBERT):**
   ```bash
   curl -X POST http://localhost:8080/embed \
     -H "Content-Type: application/json" \
     -d '{"text": "Your text here"}'
   ```

3. **Store in Vector DB (Qdrant):**
   ```bash
   curl -X PUT http://localhost:6333/collections/docs/points \
     -H "Content-Type: application/json" \
     -d '{"points": [{"id": 1, "vector": [...], "payload": {...}}]}'
   ```

4. **Query with LLM (Ollama):**
   ```bash
   curl http://localhost:11434/api/generate \
     -d '{"model": "llama2", "prompt": "Your prompt"}'
   ```

5. **Hybrid Search (Vector + Full-Text):**
   - Qdrant for semantic similarity
   - OpenSearch for keyword matching
   - Combine results for best relevance

## Source & Migration

**Migrated from:** AnotherOneBytesTheDust/ContainerStore (private)
**Sanitization date:** 2026-01-09
**Sanitization status:** ✅ Verified clean (no client/company names)

**Changes made during migration:**
- Hardcoded passwords → Environment variables
- All credentials → `.env.template` with secure defaults
- Verified no PII using automated scanner
- Updated documentation for public use

## Contributing

When modifying this stack:

1. **Test changes locally:**
   ```bash
   docker compose -f docker-compose-cpu.yml up -d
   docker compose ps
   docker compose logs
   ```

2. **Verify no secrets committed:**
   ```bash
   git diff --check
   grep -r "P@ssw0rd" .
   ```

3. **Update documentation:**
   - Update this README
   - Update `.env.template`
   - Document any new services or ports

4. **Run security scan:**
   ```bash
   # From repository root
   ./private/client-name-scanner.sh code/public/containers/compose/ai-ml-stacks/full-ai-stack/
   ```

## License

MIT License

Copyright (c) 2026 Matthew Whited / Out-of-Band Development

See LICENSE file for details.

## Related Projects

- **[dotex](https://github.com/OutOfBandDevelopment/dotex)** - .NET extensions framework
- **[RunScripts](https://github.com/OutOfBandDevelopment/RunScripts)** - Docker wrapper framework
- **[BinaryDataDecoders](https://github.com/mwwhited/BinaryDataDecoders)** - Data encoding/decoding

## Support & Contact

**GitHub:** [@mwwhited](https://github.com/mwwhited)
**Organization:** [OutOfBandDevelopment](https://github.com/OutOfBandDevelopment)

---

*Last updated: 2026-01-09*
*Version: 1.0*
*Status: Production-ready (with proper security configuration)*

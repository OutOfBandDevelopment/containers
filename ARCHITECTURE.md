# Container Repository Architecture

## Design Philosophy

This repository follows a **modular, composable architecture** where:
- **Each service is self-contained** - All files (Dockerfile, docker-compose.yml, configs) in one directory
- **Individual services are composable** - Can be run standalone or combined
- **Composite stacks at higher level** - Examples show how to compose services together

## Structure

```
containers/
├── services/                   # Individual service templates
│   ├── databases/
│   │   ├── qdrant/            # Vector database
│   │   │   ├── Dockerfile (if custom)
│   │   │   ├── docker-compose.yml
│   │   │   ├── .env.template
│   │   │   └── README.md
│   │   ├── opensearch/        # Full-text search
│   │   ├── sqlserver/
│   │   ├── paradedb/
│   │   └── mongodb/
│   ├── ai-ml/
│   │   ├── ollama/
│   │   │   ├── Dockerfile
│   │   │   ├── docker-compose.yml
│   │   │   ├── .env.template
│   │   │   └── README.md
│   │   └── sbert/
│   │       ├── Dockerfile
│   │       ├── docker-compose.yml
│   │       ├── .env.template
│   │       └── README.md
│   ├── utilities/
│   │   ├── apache-tika/
│   │   ├── pgadmin/
│   │   └── [...]
│   ├── auth/
│   │   └── keycloak/
│   │       ├── Dockerfile
│   │       ├── docker-compose.yml
│   │       ├── .env.template
│   │       ├── README.md
│   │       └── keycloak/      # Config files
│   │           └── local-dev-realm.json
│   ├── messaging/
│   │   ├── rabbitmq/
│   │   └── kafka/
│   ├── cloud-emulators/
│   │   ├── azurite/
│   │   └── localstack/
│   ├── dev-tools/
│   │   ├── jupyter/
│   │   ├── devbox/
│   │   └── [...]
│   └── fpga/
│       ├── quartus/
│       └── vivado/
├── compositions/               # Composite stacks (higher level)
│   ├── full-ai-ml-stack/
│   │   ├── docker-compose.yml
│   │   ├── .env.template
│   │   └── README.md
│   ├── vector-search-rag/
│   │   ├── docker-compose.yml  # Composes: Ollama + Qdrant + SBERT
│   │   ├── .env.template
│   │   └── README.md
│   ├── data-science/
│   │   ├── docker-compose.yml  # Composes: Jupyter + DBs + visualization
│   │   ├── .env.template
│   │   └── README.md
│   ├── fpga-development/
│   │   ├── docker-compose.yml  # Composes: Quartus/Vivado + utilities
│   │   ├── .env.template
│   │   └── README.md
│   └── microservices-dev/
│       ├── docker-compose.yml
│       ├── .env.template
│       └── README.md
├── templates/                  # Reusable templates
│   ├── .dockerignore.dotnet
│   ├── .dockerignore.python
│   └── service-template/       # Template for new services
│       ├── Dockerfile.template
│       ├── docker-compose.yml.template
│       ├── .env.template.template
│       └── README.md.template
└── docs/
    ├── composition-guide.md
    ├── service-catalog.md
    └── best-practices.md
```

## Service Structure

Each service is **completely self-contained**:

```
services/[category]/[service-name]/
├── Dockerfile              # Custom image (if needed)
├── docker-compose.yml      # Standalone deployment config
├── .env.template          # All configuration
├── README.md              # Service documentation
└── [support-files]/       # Configs, scripts, etc.
    ├── config.json
    ├── init-scripts/
    └── [...]
```

### Why This Structure?

1. **Self-Contained** - Everything for a service in one place
2. **Portable** - Copy entire directory to use elsewhere
3. **Clear Ownership** - Dockerfile and compose file stay together
4. **Easy Discovery** - One directory = one service
5. **Version Control** - Changes to service are atomic

## Service Classification

### Databases
Services that store and retrieve data:
- **Relational:** SQL Server, PostgreSQL, ParadeDB
- **Document:** MongoDB
- **Vector:** Qdrant
- **Search:** OpenSearch

### AI/ML
Services that perform AI/ML inference:
- **LLM Inference:** Ollama
- **Embeddings:** SBERT

### Utilities
Support services:
- **Document Processing:** Apache Tika
- **Database UI:** PgAdmin
- **Search UI:** OpenSearch Dashboards
- **Email Testing:** SMTP4Dev
- **LLM Interface:** Open WebUI

### Authentication
Identity and access management:
- Keycloak

### Messaging
Message brokers and streaming:
- RabbitMQ (AMQP)
- Kafka (event streaming)

### Cloud Emulators
Local cloud service emulation:
- Azurite (Azure)
- LocalStack (AWS)

### Dev Tools
Development environments:
- Jupyter (notebooks)
- DevBox (multi-language)
- COBOL, Chrome

### FPGA
FPGA development tools:
- Quartus (Intel)
- Vivado (Xilinx)

## Individual Service Usage

Each service can run standalone:

```bash
cd services/databases/qdrant
cp .env.template .env
# Edit .env with your config
docker compose up -d
```

## Composite Stack Usage

Compositions combine multiple services:

```bash
cd compositions/vector-search-rag
cp .env.template .env
# Edit .env with your config
docker compose up -d
```

The composition's `docker-compose.yml` uses the `extends` pattern:

```yaml
# compositions/vector-search-rag/docker-compose.yml
services:
  ollama:
    extends:
      file: ../../services/ai-ml/ollama/docker-compose.yml
      service: ollama
    networks:
      - rag-network

  qdrant:
    extends:
      file: ../../services/databases/qdrant/docker-compose.yml
      service: qdrant
    networks:
      - rag-network

  sbert:
    extends:
      file: ../../services/ai-ml/sbert/docker-compose.yml
      service: sbert
    networks:
      - rag-network

networks:
  rag-network:
    driver: bridge
```

## Composition Patterns

### Pattern 1: Multiple Compose Files

Run multiple individual services:

```bash
docker compose \
  -f services/ai-ml/ollama/docker-compose.yml \
  -f services/databases/qdrant/docker-compose.yml \
  up -d
```

### Pattern 2: Extends in Composition

Create a composition that extends services:

```yaml
# compositions/my-stack/docker-compose.yml
services:
  service1:
    extends:
      file: ../../services/category/service1/docker-compose.yml
      service: service1
    networks:
      - my-network
    # Override or add configuration
    environment:
      - EXTRA_VAR=value

networks:
  my-network:
```

### Pattern 3: Profiles for Optional Services

```yaml
# compositions/dev-stack/docker-compose.yml
services:
  app:
    profiles: ["core"]
    # ...

  database:
    extends:
      file: ../../services/databases/postgres/docker-compose.yml
      service: postgres
    profiles: ["core", "dev"]

  db-ui:
    extends:
      file: ../../services/utilities/pgadmin/docker-compose.yml
      service: pgadmin
    profiles: ["dev"]  # Only start with --profile dev

# Start core only
docker compose --profile core up -d

# Start with dev tools
docker compose --profile dev up -d
```

## Service Development Guidelines

### 1. Each Service Directory Contains Everything

- Dockerfile (if custom image)
- docker-compose.yml (for standalone use)
- .env.template (all configuration)
- README.md (documentation)
- Supporting files (configs, scripts)

### 2. Service docker-compose.yml Must Be Standalone

The service's compose file should work independently:

```yaml
name: service-name
services:
  service-name:
    build:
      context: .
      dockerfile: Dockerfile
    # OR
    image: official/image:tag
    ports:
      - ${SERVICE_PORT:-default}:internal
    environment:
      - VAR=${ENV_VAR:-default}
    volumes:
      - service-data:/data
    restart: unless-stopped

volumes:
  service-data:
```

### 3. Composition docker-compose.yml References Services

Compositions use `extends` to reference individual services:

```yaml
# Higher level composition
services:
  my-service:
    extends:
      file: ../../services/category/service/docker-compose.yml
      service: service-name
    networks:
      - composition-network
    depends_on:
      - other-service
```

### 4. Documentation Standards

**Service README.md:**
```markdown
# Service Name

## Overview
[What this service does]

## Service Type
Category: databases / ai-ml / utilities / etc.

## Quick Start

### Standalone
```bash
cd services/category/service-name
cp .env.template .env
docker compose up -d
```

### As Part of Composition
See compositions:
- compositions/full-ai-ml-stack/
- compositions/vector-search-rag/

## Configuration
[Environment variables, ports, volumes]

## Usage Examples
[How to use the service]
```

**Composition README.md:**
```markdown
# Composition Name

## Overview
[What this composition provides]

## Services Included
- Service 1 (category)
- Service 2 (category)
- Service 3 (category)

## Quick Start
```bash
cd compositions/composition-name
cp .env.template .env
docker compose up -d
```

## Architecture
[How services connect]

## Configuration
[Composition-specific settings]
```

## Migration Strategy

### Phase 1: Convert Individual Services
Move each service to self-contained structure:
- Copy Dockerfile (if exists)
- Create standalone docker-compose.yml
- Generate .env.template
- Write README.md

### Phase 2: Create Compositions
Build higher-level compositions:
- Use `extends` to reference services
- Add networking and dependencies
- Document the composition

### Phase 3: Add RunScripts Services
Migrate RunScripts Dockerfiles:
- Each becomes a self-contained service
- Add compose file for standalone use
- Document and classify

## Benefits

1. **Self-Contained Services** - Everything in one directory
2. **Composability** - Mix and match services easily
3. **Portability** - Copy directory to use elsewhere
4. **Clear Structure** - Service files stay together
5. **Reusability** - Use services standalone or in compositions
6. **Discoverability** - One directory = one service
7. **Maintainability** - Atomic changes per service
8. **Flexibility** - Create custom compositions easily

---

*Version: 3.0*
*Date: 2026-01-09*
*Status: Self-contained services with higher-level compositions*

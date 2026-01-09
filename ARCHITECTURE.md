# Container Repository Architecture

## Design Philosophy

This repository follows a **modular, composable architecture** where each service is a self-contained, independently deployable unit that can be easily combined with other services.

## Structure

```
containers/
├── services/                   # Individual service templates (composable units)
│   ├── databases/             # Database services (relational, document, vector, search)
│   │   ├── postgres/
│   │   ├── sqlserver/
│   │   ├── mongodb/
│   │   ├── paradedb/          # PostgreSQL with extensions
│   │   ├── qdrant/            # Vector database
│   │   └── opensearch/        # Full-text search database
│   ├── ai-ml/                 # AI/ML inference and processing
│   │   ├── ollama/            # LLM inference
│   │   └── sbert/             # Sentence embeddings
│   ├── dev-tools/             # Development environments
│   │   ├── jupyter/
│   │   ├── devbox/
│   │   ├── cobol/
│   │   └── chrome/
│   ├── fpga/                  # FPGA development tools
│   │   ├── quartus/
│   │   └── vivado/
│   ├── auth/                  # Authentication services
│   │   └── keycloak/
│   ├── messaging/             # Message brokers and queues
│   │   ├── rabbitmq/
│   │   └── kafka/
│   ├── utilities/             # Utility and support services
│   │   ├── apache-tika/       # Document processing
│   │   ├── pgadmin/           # PostgreSQL management UI
│   │   ├── opensearch-dashboards/  # OpenSearch UI
│   │   ├── smtp4dev/          # SMTP test server
│   │   └── open-webui/        # LLM web interface
│   └── cloud-emulators/       # Cloud service emulators
│       ├── azurite/           # Azure Storage emulator
│       └── localstack/        # AWS services emulator
├── examples/                   # Example compositions
│   ├── full-ai-ml-stack/      # Complete AI/ML development stack
│   ├── data-science/          # Jupyter + databases + visualization
│   ├── microservices-dev/     # Microservices development environment
│   ├── fpga-development/      # FPGA tools + utilities
│   └── basic-web-app/         # Simple web app stack
├── templates/                  # Reusable templates
│   ├── .dockerignore.dotnet
│   ├── .env.template
│   └── docker-compose.template.yml
└── docs/
    ├── composition-guide.md   # How to compose services together
    ├── service-catalog.md     # Complete catalog of all services
    └── best-practices.md      # Best practices and patterns
```

## Service Classification

### Databases
**Criteria:** Services that primarily store and retrieve data

- **Relational:** PostgreSQL, SQL Server, ParadeDB
- **Document:** MongoDB
- **Vector:** Qdrant (vector similarity search)
- **Search:** OpenSearch (full-text search engine)

### AI/ML
**Criteria:** Services that perform AI/ML inference or model operations

- **LLM Inference:** Ollama
- **Embeddings:** SBERT (sentence transformers)

### Utilities
**Criteria:** Support services that process, transform, or manage other services

- **Document Processing:** Apache Tika (extract text/metadata from documents)
- **Database Management:** PgAdmin (PostgreSQL UI)
- **Search UI:** OpenSearch Dashboards
- **Email Testing:** SMTP4Dev
- **LLM Interface:** Open WebUI

### Authentication
**Criteria:** Identity and access management

- Keycloak (OAuth2, OIDC, SAML)

### Messaging
**Criteria:** Message brokers, event streaming, queuing

- RabbitMQ (AMQP broker)
- Kafka (event streaming)

### Cloud Emulators
**Criteria:** Local emulation of cloud services

- Azurite (Azure Storage)
- LocalStack (AWS services)

### Dev Tools
**Criteria:** Development environments and IDEs

- Jupyter (multi-kernel notebooks)
- DevBox (comprehensive dev environment)
- COBOL (GNU COBOL compiler)
- Chrome (browser in container)

### FPGA
**Criteria:** FPGA development and synthesis tools

- Quartus (Intel FPGA tools)
- Vivado (Xilinx FPGA tools)

## Service Template Structure

Each service is a self-contained directory with:

### Required Files

1. **docker-compose.yml** - Standalone deployment configuration
   - Service can be started independently: `docker compose up -d`
   - Uses environment variables for configuration
   - Defines networks, volumes, and dependencies
   - Can be composed with other services

2. **README.md** - Service documentation
   - Purpose and features
   - Configuration options
   - Usage examples (standalone and composed)
   - Port mappings
   - Volume mounts
   - Environment variables

3. **.env.template** - Configuration template
   - All environment variables with defaults
   - Comments explaining each variable
   - Security notes

### Optional Files

4. **Dockerfile** - Custom image (if needed)
   - Only if the service requires a custom image
   - Base on official images when possible
   - Include build instructions in README

5. **Supporting files** - Configuration files, scripts, etc.
   - Realm exports (Keycloak)
   - Init scripts (databases)
   - Configuration files

## Composition Patterns

### Pattern 1: Include Multiple Compose Files

Run multiple services together:

```bash
# Start Jupyter + PostgreSQL + PgAdmin
docker compose \
  -f services/dev-tools/jupyter/docker-compose.yml \
  -f services/databases/postgres/docker-compose.yml \
  -f services/utilities/pgadmin/docker-compose.yml \
  up -d
```

### Pattern 2: Extends Pattern

Create a new composition that extends individual services:

```yaml
# examples/data-science/docker-compose.yml
services:
  jupyter:
    extends:
      file: ../../services/dev-tools/jupyter/docker-compose.yml
      service: jupyter
    networks:
      - data-science
    depends_on:
      - postgres

  postgres:
    extends:
      file: ../../services/databases/postgres/docker-compose.yml
      service: postgres
    networks:
      - data-science

  pgadmin:
    extends:
      file: ../../services/utilities/pgadmin/docker-compose.yml
      service: pgadmin
    networks:
      - data-science
    depends_on:
      - postgres

networks:
  data-science:
    driver: bridge
```

### Pattern 3: Profiles

Use Docker Compose profiles for optional services:

```yaml
# docker-compose.yml
services:
  app:
    image: myapp
    profiles: ["core"]

  postgres:
    extends:
      file: services/databases/postgres/docker-compose.yml
      service: postgres
    profiles: ["core", "dev"]

  pgadmin:
    extends:
      file: services/utilities/pgadmin/docker-compose.yml
      service: pgadmin
    profiles: ["dev"]

# Start core services only
docker compose --profile core up -d

# Start core + dev tools
docker compose --profile dev up -d
```

## Service Development Guidelines

### 1. Each Service is Independent

- Can be started standalone
- Has its own configuration
- Documents its own dependencies
- Defines its own networks and volumes

### 2. Use Environment Variables

- ALL configuration via environment variables
- Provide sensible defaults
- Document required vs optional variables
- Never hardcode secrets

### 3. Follow Naming Conventions

**Service names:** lowercase-with-hyphens
**Ports:** Use standard ports, make configurable
**Volumes:** Prefix with service name (e.g., `postgres-data`)
**Networks:** Define but allow override

### 4. Documentation Standards

Each README.md should include:

```markdown
# Service Name

## Overview
[What this service does]

## Service Type
Category: [databases/ai-ml/utilities/etc.]

## Quick Start

### Standalone
```bash
cd services/category/service-name
cp .env.template .env
# Edit .env
docker compose up -d
```

### Composed with Other Services
[Example showing composition]

## Configuration

### Environment Variables
[Table of all variables]

### Volumes
[What data is persisted]

### Ports
[What ports are exposed]

## Usage Examples

### Example 1: [Use case]
[Code example]

## Composition Examples

See also:
- examples/xxx - [Description]
- examples/yyy - [Description]
```

## Examples Directory

The examples/ directory contains **complete, working stacks** that demonstrate:

1. **How to compose multiple services**
2. **Real-world use cases**
3. **Best practices for production**
4. **Common development scenarios**

Each example includes:
- Complete docker-compose.yml
- .env.template with all required variables
- Comprehensive README
- Setup and teardown scripts

## Migration Strategy

### Phase 1: Reorganize Existing

Move current services to new structure:
- `compose/ai-ml-stacks/full-ai-stack/` → Individual services in `services/`
- Create example composition in `examples/full-ai-ml-stack/`

### Phase 2: Add RunScripts Images

Migrate RunScripts Dockerfiles as services:
- Each Dockerfile becomes a service directory
- Create compose files for standalone usage
- Document composition patterns

### Phase 3: Create Examples

Build example compositions:
- Data science stack (Jupyter + DBs + visualization)
- FPGA development (Quartus/Vivado + utilities)
- Microservices dev (multiple languages + databases + messaging)

## Benefits of This Architecture

1. **Modularity** - Use only what you need
2. **Reusability** - Services work standalone or composed
3. **Discoverability** - Clear catalog of available services
4. **Flexibility** - Mix and match any combination
5. **Maintainability** - Each service is independently maintained
6. **Documentation** - Each service documents itself
7. **Examples** - Real-world compositions show best practices
8. **Correct Classification** - Services grouped by actual service type

---

*Version: 2.1*
*Date: 2026-01-09*
*Status: Architecture design - services classified by type*

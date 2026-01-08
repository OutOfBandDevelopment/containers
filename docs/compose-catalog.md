# Docker Compose Stack Catalog

Complete catalog of all Docker Compose stacks in this repository.

## Status

**Total Stacks:** 0
**Last Updated:** 2026-01-08

## Categories

- [Development Environments](#development-environments) - Full-stack development setups
- [Databases](#databases) - Database management environments
- [AI/ML Stacks](#aiml-stacks) - AI/ML service combinations
- [Utilities](#utilities) - Management and monitoring tools

---

## Development Environments

Complete development environments with all services configured and ready to use.

**Total:** 0 stacks

*No stacks migrated yet. Check back after Phase 3 migration completes.*

### Planned Stacks

- **dotnet-full-stack:** ASP.NET Core API + SQL Server + React frontend
- **node-react-stack:** Node.js API + PostgreSQL + React frontend
- **python-data-science:** Jupyter + PostgreSQL + Redis

---

## Databases

Database management environments with admin tools and utilities.

**Total:** 0 stacks

*No stacks migrated yet.*

### Planned Stacks

- **postgres-pgadmin:** PostgreSQL + pgAdmin for database management
- **sqlserver-management:** SQL Server + Azure Data Studio web
- **mongodb-express:** MongoDB + Mongo Express

---

## AI/ML Stacks

Production-ready AI/ML service combinations for machine learning workflows.

**Total:** 0 stacks

*No stacks migrated yet.*

### Planned Stacks

**Priority:** These will be migrated from ContainerStore (private) after sanitization:

- **ollama-qdrant:** LLM inference + vector database
- **sbert-opensearch:** Sentence embeddings + text search
- **full-ai-stack:** Complete 19-service AI/ML development environment
  - Ollama (LLM inference)
  - Qdrant (vector database)
  - SBERT (sentence embeddings)
  - OpenSearch (text search)
  - Apache Tika (document processing)
  - Keycloak (authentication)
  - RabbitMQ/Kafka (message queues)
  - PostgreSQL/MongoDB (databases)
  - Traefik (reverse proxy)
  - GPU support (CUDA variants)

---

## Utilities

Management and monitoring tools for container orchestration.

**Total:** 0 stacks

*No stacks migrated yet.*

### Planned Stacks

- **portainer:** Container management UI
- **monitoring-stack:** Prometheus + Grafana + Node Exporter
- **logging-stack:** ELK stack (Elasticsearch + Logstash + Kibana)

---

## Stack Entry Template

Use this template when adding new compose stacks to the catalog:

### stack-name

| Field | Value |
|:------|:------|
| **Location** | compose/[category]/[name]/ |
| **Purpose** | Brief description of stack purpose |
| **Services** | N services |
| **GPU Support** | Yes / No |
| **Ports** | 8080, 8081, 5432, etc. |

**Services:**
- **service1** (image:tag): Purpose and exposed port
- **service2** (image:tag): Purpose and exposed port
- **service3** (image:tag): Purpose and exposed port

**Prerequisites:**
- Docker Compose v2.x or higher
- Minimum 8GB RAM
- [Other requirements]

**Quick Start:**
```bash
cd compose/[category]/[name]
cp .env.template .env
# Edit .env with your configuration
docker compose up -d
```

**Configuration:**

Key environment variables (see .env.template for complete list):
- `SERVICE_PORT`: Service port (default: 8080)
- `DATABASE_URL`: Database connection string
- `API_KEY`: API key for external services

**Accessing Services:**
- Service 1: http://localhost:8080
- Service 2: http://localhost:8081
- Service 3: http://localhost:5432

**Volumes:**
- `service1-data`: Persistent data for service 1
- `service2-config`: Configuration files for service 2

**Networks:**
- `app-network`: Internal communication between services

**Source:** [Original project or created new]

**Notes:** [Special considerations, known issues, performance tips]

---

## Migration Priority

### High Priority (Public Assets)
1. **RunScripts patterns** - Docker wrapper scripts converted to compose utilities
2. **CQRS-Examples** - .NET microservices example stack
3. **Learning project examples** - Educational compose stacks

### Medium Priority (Private Assets - Requires Sanitization)
1. **ContainerStore AI/ML stack** - 19-service development environment (EXCELLENT reference)
2. **eliassen-dotnet-libs infrastructure** - .NET microservices patterns
3. **Client project patterns** - Sanitized generic versions

### Low Priority
1. Legacy or deprecated configurations
2. Highly client-specific setups

---

## Sanitization Status

All stacks migrated from private repositories undergo PII sanitization:

- ✅ **Client/employer names removed** (replaced with "Out-of-Band Development")
- ✅ **API keys/credentials** moved to .env.template with placeholders
- ✅ **Domain names** replaced with example.com
- ✅ **Internal IPs** replaced with RFC 1918 ranges
- ✅ **Scanner verification** passed (no PII detected)

See `docs/migration-guide.md` for complete sanitization procedures.

---

*Last updated: 2026-01-08*
*Next review: After Phase 3 public asset migration and Phase 4 private asset sanitization*

# Docker Containers Collection

Centralized repository for Docker containers, services, and compositions from Matthew Whited's projects.

**Status:** ✅ Migration Complete (2026-01-09)
**Services:** 34 | **Compositions:** 2 | **Architecture:** v3.0

## Quick Navigation

- **[Migration Status](MIGRATION_STATUS.md)** - Complete migration summary
- **[Architecture](ARCHITECTURE.md)** - Architecture v3.0 design and patterns
- **[Style Guide](STYLE_GUIDE.md)** - Naming conventions and file structures
- **[Composition Guide](COMPOSITION_GUIDE.md)** - Creating multi-platform compositions
- **[Source Tracking](SOURCE_TRACKING.md)** - Service source inventory

## Architecture v3.0

**Self-contained services with higher-level compositions**

### Directory Structure

```
containers/
├── services/                  # Self-contained services (34 total)
│   ├── databases/            # Database services (5)
│   │   ├── mongodb/          # MongoDB document database
│   │   ├── opensearch/       # Full-text search engine
│   │   ├── paradedb/         # PostgreSQL with extensions
│   │   ├── qdrant/           # Vector database
│   │   └── sql-server/       # Microsoft SQL Server
│   ├── ai-ml/                # AI/ML services (4)
│   │   ├── comfyui/          # AI image generation
│   │   ├── ollama/           # LLM inference engine
│   │   ├── sbert/            # Sentence embeddings
│   │   └── tensorflow-jupyterlab/  # TensorFlow with Jupyter
│   ├── utilities/            # Utility services (7)
│   │   ├── apache-tika/      # Document text extraction
│   │   ├── open-webui/       # LLM chat interface
│   │   ├── opensearch-dashboards/  # OpenSearch UI
│   │   ├── pgadmin/          # PostgreSQL management UI
│   │   ├── searxng/          # Privacy-respecting search
│   │   ├── smtp4dev/         # SMTP test server
│   │   └── wine/             # Windows compatibility layer
│   ├── dev-tools/            # Development tools (11)
│   │   ├── dev-node/         # Node.js development
│   │   ├── dev-dotnet/       # .NET development
│   │   ├── dev-python/       # Python development
│   │   ├── dev-go/           # Go development
│   │   ├── dev-rust/         # Rust development
│   │   ├── dev-java/         # Java development
│   │   ├── devbox/           # Polyglot environment
│   │   ├── gnucobol/         # COBOL compiler
│   │   ├── google-chrome/    # Chrome browser
│   │   ├── jupyter/          # Multi-kernel Jupyter Lab
│   │   └── plantuml/         # PlantUML diagram server
│   ├── messaging/            # Message brokers (2)
│   │   ├── kafka/            # Event streaming
│   │   └── rabbitmq/         # AMQP message broker
│   ├── cloud-emulators/      # Cloud service emulators (2)
│   │   ├── azurite/          # Azure Storage emulator
│   │   └── localstack/       # AWS services emulator
│   ├── auth/                 # Authentication (1)
│   │   └── keycloak/         # OAuth2/OIDC/SAML
│   └── fpga-tools/           # FPGA development (2)
│       ├── quartus/          # Intel Quartus
│       └── vivado/           # AMD/Xilinx Vivado
├── compositions/              # Higher-level stacks (2 total)
│   ├── vector-search-rag/    # Ollama + Qdrant + SBERT
│   └── ai-workspace/         # Open WebUI + Ollama + SearXNG + Tika + nginx
├── templates/                 # Reusable templates
│   ├── .dockerignore.dotnet  # .NET .dockerignore
│   └── dotnet-app/           # Generic .NET application
├── docs/                      # Documentation
│   ├── migration-guide.md    # Migration procedures
│   ├── compose-catalog.md    # Legacy compose catalog
│   └── image-catalog.md      # Custom image catalog
└── scripts/                   # Utility scripts
    └── scan-docker-assets.sh # Asset inventory scanner
```

## Quick Start

### Using a Service

Each service is self-contained and can be deployed standalone:

```bash
cd services/ai-ml/ollama
./start.sh

# Access at configured port (see .env.template)
```

### Using a Composition

Compositions combine multiple services with multi-platform support:

```bash
cd compositions/ai-workspace

# Docker Compose (development)
./scripts/deploy-compose.sh

# Docker Swarm (production)
./scripts/deploy-swarm.sh

# Kubernetes/Helm
./scripts/deploy-helm.sh ai-workspace dev
```

## Service Categories

### Databases (5 services)
Data storage and retrieval services:
- **mongodb** - Document database
- **opensearch** - Full-text search and analytics
- **paradedb** - PostgreSQL with vector and full-text search extensions
- **qdrant** - Vector database for similarity search
- **sql-server** - Microsoft SQL Server

### AI/ML (4 services)
Machine learning and AI inference:
- **comfyui** - AI image generation with Stable Diffusion
- **ollama** - Local LLM inference (Llama, Mistral, etc.)
- **sbert** - Sentence embeddings service
- **tensorflow-jupyterlab** - TensorFlow with Jupyter Lab

### Utilities (7 services)
Support services for processing and management:
- **apache-tika** - Document text extraction and parsing
- **open-webui** - Web interface for LLMs
- **opensearch-dashboards** - OpenSearch visualization
- **pgadmin** - PostgreSQL management UI
- **searxng** - Privacy-respecting metasearch engine
- **smtp4dev** - SMTP test server
- **wine** - Windows compatibility layer

### Dev Tools (11 services)
Development environments and tools:
- **dev-node, dev-dotnet, dev-python, dev-go, dev-rust, dev-java** - Lightweight language-specific containers
- **devbox** - Polyglot development environment (Node, .NET, Java, Go, Rust, PlatformIO, Claude Code)
- **gnucobol** - GNU COBOL compiler
- **google-chrome** - Chrome browser with WSLg support
- **jupyter** - Multi-kernel Jupyter Lab (Python, .NET, Java, Go, Ruby, TypeScript)
- **plantuml** - PlantUML diagram rendering server

### Messaging (2 services)
Message brokers and event streaming:
- **kafka** - Distributed event streaming platform
- **rabbitmq** - AMQP message broker

### Cloud Emulators (2 services)
Local cloud service emulation:
- **azurite** - Azure Storage emulator (Blob, Queue, Table)
- **localstack** - AWS services emulator (S3, DynamoDB, Lambda, etc.)

### Auth (1 service)
Identity and access management:
- **keycloak** - OAuth2/OIDC/SAML authentication server

### FPGA Tools (2 services)
FPGA development environments:
- **quartus** - Intel Quartus (requires manual installation)
- **vivado** - AMD/Xilinx Vivado (requires manual installation)

## Compositions

### vector-search-rag
**Services:** Ollama + Qdrant + SBERT
**Purpose:** Vector search and RAG (Retrieval Augmented Generation)
**Platforms:** Docker Compose, Docker Swarm, Kubernetes/Helm

Complete stack for semantic search and RAG applications:
- Ollama for LLM inference
- Qdrant for vector similarity search
- SBERT for generating embeddings

```bash
cd compositions/vector-search-rag
./scripts/deploy-compose.sh
```

### ai-workspace
**Services:** Open WebUI + Ollama + SearXNG + Apache Tika + nginx
**Purpose:** Complete AI workspace with unified interface
**Platforms:** Docker Compose, Docker Swarm, Kubernetes/Helm

All-in-one AI development environment with nginx reverse proxy:
- Open WebUI for LLM chat (served at root `/`)
- Ollama for LLM inference
- SearXNG for privacy-respecting web search
- Apache Tika for document processing
- Path-based routing via nginx

```bash
cd compositions/ai-workspace
./scripts/deploy-compose.sh
# Access at http://localhost/
```

## Service Structure

Each service follows a standardized structure:

```
service-name/
├── docker-compose.yml         # Standalone deployment
├── .env.template              # Configuration with defaults
├── README.md                  # Complete documentation
├── start.sh / start.bat       # Cross-platform start scripts
├── stop.sh / stop.bat         # Cross-platform stop scripts
├── Dockerfile                 # Custom image (if needed)
└── build.sh / build.bat       # Build scripts (if custom image)
```

### Service README Sections
1. Title and description
2. Overview
3. Features
4. Quick Start
5. Configuration
6. Usage Examples
7. Persistent Volumes
8. Use in Compositions
9. Behind Reverse Proxy (if applicable)
10. Documentation links
11. Source Tracking
12. Service Type/Category/Deployment

## Composition Structure

Each composition supports multiple deployment platforms:

```
composition-name/
├── docker-compose.yml         # Compose deployment (extends pattern)
├── docker-compose.swarm.yml   # Swarm deployment with replicas
├── .env.template              # Unified configuration
├── helm/                      # Kubernetes/Helm chart
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── values-dev.yaml
│   ├── values-prod.yaml
│   └── templates/
├── scripts/                   # Deployment scripts
│   ├── deploy-compose.sh/bat
│   ├── stop-compose.sh/bat
│   ├── deploy-swarm.sh
│   ├── remove-swarm.sh
│   └── deploy-helm.sh
├── nginx/                     # nginx config (if applicable)
└── README.md                  # Documentation with PlantUML diagrams
```

### Composition README Sections
1. Overview
2. Services Overview Table
3. Architecture (PlantUML diagrams embedded)
4. Quick Start (all 3 platforms)
5. Quick Reference Card
6. Configuration
7. Usage Examples
8. Behind Reverse Proxy
9. Deployment Platforms
10. Troubleshooting
11. Security Considerations
12. Performance Tuning
13. Monitoring
14. Documentation links

## Key Features

### Multi-Platform Support
- **Docker Compose** - Development, single-host deployments
- **Docker Swarm** - Production clustering with replicas, resource limits, rolling updates
- **Kubernetes/Helm** - Cloud-native with ingress, TLS, autoscaling

### Complete Documentation
- PlantUML C4 diagrams embedded in markdown
- Services overview tables
- Quick reference cards
- Health check examples
- Persistent volumes documented
- Complete API usage examples
- Troubleshooting guides

### Source Tracking
All services tracked with:
- Source repository name
- Git commit hash
- Source date
- Original file path

See `SOURCE_TRACKING.md` for complete inventory.

### Cross-Platform Scripts
All services include both `.sh` and `.bat` scripts for Linux/macOS and Windows compatibility.

### Standardized Configuration
- `.env.template` with defaults for all variables
- Comments explaining each setting
- Version pinning capability
- Port configuration

## Migration Sources

| Source Repository | Services | Commit Hash |
|:------------------|:---------|:------------|
| AnotherOneBytesTheDust/ContainerStore | 17 | `fe623ee56a7289bbb1602c9f9cadf6c214496612` |
| RunScripts | 9 | `859fc4da005996424df7f5cdde45c3d56768b3ad` |
| shared | 1 | `7e8df998557b15f247aa0fea1444a1d10b1cd2b1` |
| New Services | 7 | Created for compositions |
| **Total** | **34** | |

## Documentation

### Core Documentation
- [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture v3.0 design
- [STYLE_GUIDE.md](STYLE_GUIDE.md) - Naming and file structure conventions
- [COMPOSITION_GUIDE.md](COMPOSITION_GUIDE.md) - Multi-platform composition creation
- [MIGRATION_STATUS.md](MIGRATION_STATUS.md) - Complete migration summary
- [SOURCE_TRACKING.md](SOURCE_TRACKING.md) - Service source inventory

### Guides
- [docs/migration-guide.md](docs/migration-guide.md) - Migration procedures and sanitization
- [docs/compose-catalog.md](docs/compose-catalog.md) - Legacy compose stacks catalog
- [docs/image-catalog.md](docs/image-catalog.md) - Custom Docker images catalog

## Contributing

When adding new services:

1. Follow Architecture v3.0 patterns (see `ARCHITECTURE.md`)
2. Use standardized file structure (see `STYLE_GUIDE.md`)
3. Include comprehensive README (13-14 sections)
4. Provide both .sh and .bat scripts
5. Add source tracking information
6. Update `SOURCE_TRACKING.md` and `MIGRATION_STATUS.md`

For compositions:

1. Support all 3 platforms (Compose, Swarm, Helm)
2. Embed PlantUML diagrams in README
3. Include services overview table
4. Add quick reference card
5. Document all access points, health checks, volumes
6. Follow `COMPOSITION_GUIDE.md` standards

## License

See individual service READMEs for license information. Most services use official Docker images or open-source software with their respective licenses.

---

**Repository Owner:** Matthew Whited ([@mwwhited](https://github.com/mwwhited))
**Organization:** [Out-of-Band Development](https://github.com/OutOfBandDevelopment)
**Migration Completed:** 2026-01-09
**Total Services:** 34
**Total Compositions:** 2

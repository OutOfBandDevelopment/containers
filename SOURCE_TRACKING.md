# Source Tracking Inventory

This document tracks the original source of each migrated service, including the submodule, commit hash, and source date. This allows us to check for updates and maintain traceability.

## Purpose

When migrating Docker services from other repositories, we track:
- Source repository/submodule
- Commit hash at time of migration
- Date of source commit
- Original file path

This enables:
- Checking for updates in source repositories
- Understanding service provenance
- Maintaining accurate attribution

## Tracking Format

Each service README includes a "Source Tracking" section:

```markdown
## Source Tracking

**Migrated from:** [repository-name]
**Source commit:** `[commit-hash]`
**Source date:** [YYYY-MM-DD]
**Source file:** `[original-file-path]`
```

## Inventory

### Databases

#### Qdrant
- **Location:** `services/databases/qdrant/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.qdrant.yml`

#### OpenSearch
- **Location:** `services/databases/opensearch/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.opensearch.yml`

#### SQL Server
- **Location:** `services/databases/sql-server/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.sql-server.yml`

#### ParadeDB
- **Location:** `services/databases/paradedb/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.paradedb.yml`

#### MongoDB
- **Location:** `services/databases/mongodb/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.mongodb.yml`

### AI/ML Services

#### Ollama
- **Location:** `services/ai-ml/ollama/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.ollama.yml`

#### SBERT (Consolidated)
- **Location:** `services/ai-ml/sbert/`
- **Migrated from:**
  - AnotherOneBytesTheDust/ContainerStore (CPU version)
  - RunScripts (CPU and CUDA versions)
- **Source commits:**
  - ContainerStore: `fe623ee56a7289bbb1602c9f9cadf6c214496612` (2025-09-16)
  - RunScripts: `[commit-hash-needed]` (2025-XX-XX)
- **Source files:**
  - `docker-compose.sbert.yml` (ContainerStore)
  - `SBERT/Dockerfile` (RunScripts CPU)
  - `SBERT-CUDA/Dockerfile` (RunScripts CUDA)
- **Notes:** Consolidated 3 versions into 1 with build args and profiles

### Utilities

#### Apache Tika
- **Location:** `services/utilities/apache-tika/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.apache-tika.yml`

#### pgAdmin
- **Location:** `services/utilities/pgadmin/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.pgadmin.yml`

#### OpenSearch Dashboards
- **Location:** `services/utilities/opensearch-dashboards/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.opensearch-dashboards.yml`

#### SMTP4Dev
- **Location:** `services/utilities/smtp4dev/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.smtp4dev.yml`

#### Open WebUI
- **Location:** `services/utilities/open-webui/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.open-webui.yml`

### Messaging

#### RabbitMQ
- **Location:** `services/messaging/rabbitmq/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.rabbitmq.yml`

#### Apache Kafka
- **Location:** `services/messaging/kafka/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.kafka.yml`

### Cloud Emulators

#### Azurite
- **Location:** `services/cloud-emulators/azurite/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.azurite.yml`

#### LocalStack
- **Location:** `services/cloud-emulators/localstack/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source file:** `docker-compose.localstack.yml`

### Authentication

#### Keycloak
- **Location:** `services/auth/keycloak/`
- **Migrated from:** AnotherOneBytesTheDust/ContainerStore
- **Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
- **Source date:** 2025-09-16
- **Source files:** `docker-compose.keycloak.yml`, `DockerFile.keycloak`, `local-dev-realm.json`

### Development Tools

#### Jupyter Lab (Multi-Kernel)
- **Location:** `services/dev-tools/jupyter/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.jupyter`
- **Notes:** Multi-language Jupyter Lab with Python, .NET, Java, Go, Ruby, TypeScript kernels

#### DevBox
- **Location:** `services/dev-tools/devbox/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.devbox`
- **Notes:** Polyglot development environment with Node.js, .NET, Java, Go, Rust, PlatformIO, Claude Code CLI

#### GNU COBOL
- **Location:** `services/dev-tools/gnucobol/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.gnucobol`
- **Notes:** GNU COBOL compiler for COBOL development

#### Google Chrome
- **Location:** `services/dev-tools/google-chrome/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source files:** `MorePower/DockerFile.google-chrome`, `MorePower/chrome-start.sh`
- **Notes:** Chrome browser with WSLg support and remote debugging

#### PlantUML Server
- **Location:** `services/dev-tools/plantuml/`
- **Migrated from:** shared
- **Source commit:** `7e8df998557b15f247aa0fea1444a1d10b1cd2b1`
- **Source date:** 2025-10-23
- **Source file:** `Scripts/containers/docker-compose.plantuml.yml`
- **Notes:** Web-based PlantUML diagram rendering server with REST API

### AI/ML Services (Additional)

#### ComfyUI
- **Location:** `services/ai-ml/comfyui/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.comfyui`
- **Notes:** Uses third-party image xingren23/comfyui:comfyui-cu121-v1.0.7

#### TensorFlow Jupyter Lab
- **Location:** `services/ai-ml/tensorflow-jupyterlab/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.tensorflow-jupyterlab`
- **Notes:** TensorFlow with Jupyter Lab and data science libraries

### Utilities (Additional)

#### Wine
- **Location:** `services/utilities/wine/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.wine`
- **Notes:** Windows compatibility layer with WSLg support

### FPGA Tools

#### Intel Quartus
- **Location:** `services/fpga-tools/quartus/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.Quartus`
- **Notes:** Dependencies only - requires manual Quartus installation from Intel

#### AMD/Xilinx Vivado
- **Location:** `services/fpga-tools/vivado/`
- **Migrated from:** RunScripts
- **Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
- **Source date:** 2026-01-09
- **Source file:** `MorePower/DockerFile.Vivado`
- **Notes:** Dependencies only - requires manual Vivado installation from AMD/Xilinx

### Individual Language Development Containers

#### dev-node
- **Location:** `services/dev-tools/dev-node/`
- **Created:** 2026-01-09
- **Notes:** Lightweight Node.js development container using official node:lts image

#### dev-dotnet
- **Location:** `services/dev-tools/dev-dotnet/`
- **Created:** 2026-01-09
- **Notes:** Lightweight .NET development container using official mcr.microsoft.com/dotnet/sdk:9.0 image

#### dev-python
- **Location:** `services/dev-tools/dev-python/`
- **Created:** 2026-01-09
- **Notes:** Lightweight Python development container using official python:3.12 image

#### dev-go
- **Location:** `services/dev-tools/dev-go/`
- **Created:** 2026-01-09
- **Notes:** Lightweight Go development container using official golang:1.23 image

#### dev-rust
- **Location:** `services/dev-tools/dev-rust/`
- **Created:** 2026-01-09
- **Notes:** Lightweight Rust development container using official rust:latest image

#### dev-java
- **Location:** `services/dev-tools/dev-java/`
- **Created:** 2026-01-09
- **Notes:** Lightweight Java development container using official eclipse-temurin:21-jdk image

### Utilities (Additional)

#### SearXNG
- **Location:** `services/utilities/searxng/`
- **Created:** 2026-01-09
- **Notes:** Privacy-respecting metasearch engine, created for ai-workspace composition

### Templates

#### .NET Application
- **Location:** `templates/dotnet-app/`
- **Migrated from:** code/learn/CQRS-Examples
- **Source commit:** `[commit-hash-needed]`
- **Source date:** 2025-XX-XX
- **Source file:** `Dockerfile`
- **Notes:** Generalized from specific example to reusable template

---

## Update Procedure

When checking for updates from source repositories:

1. **Check source repository:**
   ```bash
   cd /current/src/[source-path]
   git log --since="[source-date]" -- [source-file]
   ```

2. **If updates found:**
   - Review changes in source
   - Determine if updates should be migrated
   - Update service in containers repository
   - Update source commit hash and date in this document
   - Update source tracking section in service README

3. **Document changes:**
   - Note what was updated
   - Reference source commit range
   - Update MIGRATION_STATUS.md if significant

---

*Created: 2026-01-09*
*Last updated: 2026-01-09*
*Services tracked: 34 (17 from ContainerStore, 9 from RunScripts, 1 from shared, 7 created new)*

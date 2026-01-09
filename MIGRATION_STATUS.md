# Container Migration Status

**Date:** 2026-01-09
**Status:** In Progress - Restructuring to Modular Architecture

## Architecture Change

**From:** Monolithic compose files
**To:** Modular, composable service templates grouped by service type

See `ARCHITECTURE.md` for complete design and service classification criteria.

## Service Classification (Corrected)

Services are now classified by **actual service type**, not by domain:

### Databases (6 services)
Services that store and retrieve data:
- **sqlserver** - SQL Server
- **paradedb** - PostgreSQL with extensions
- **mongodb** - MongoDB document database
- **qdrant** - Vector database for similarity search
- **opensearch** - Full-text search engine
- **postgres** - Standard PostgreSQL (to be added)

### AI/ML (2 services)
Services that perform AI/ML inference:
- **ollama** - LLM inference ✅ COMPLETE
- **sbert** - Sentence embeddings

### Utilities (5 services)
Support services for processing, management, and UI:
- **apache-tika** - Document text extraction
- **pgadmin** - PostgreSQL management UI
- **opensearch-dashboards** - OpenSearch UI
- **open-webui** - LLM chat interface
- **smtp4dev** - SMTP test server

### Authentication (1 service)
Identity and access management:
- **keycloak** - OAuth2/OIDC/SAML (complex: custom Dockerfile + realm config)

### Messaging (2 services)
Message brokers and event streaming:
- **rabbitmq** - AMQP message broker
- **kafka** - Event streaming platform

### Cloud Emulators (2 services)
Local emulation of cloud services:
- **azurite** - Azure Storage emulator
- **localstack** - AWS services emulator

**Total: 18 services** (1 complete, 17 remaining)

## Completed Work

### ✅ Phase 1: Architecture & Template

1. **Architecture Design** (`ARCHITECTURE.md`)
   - Service classification by type
   - Modular, composable structure
   - Composition patterns documented

2. **Service Template Example** (Ollama - COMPLETE)
   - Location: `services/ai-ml/ollama/`
   - Files: docker-compose.yml, .env.template, README.md, Dockerfile
   - Pattern to follow for remaining 17 services

3. **Full AI/ML Stack Sanitized**
   - Source: Private AnotherOneBytesTheDust/ContainerStore
   - Location: `compose/ai-ml-stacks/full-ai-stack/`
   - Status: ✅ All 19 compose files sanitized and verified (no PII)
   - Ready to be split into individual services

4. **Directory Structure Created**
   - All service type directories created
   - Ready for migration

## Work In Progress

### 🔄 Converting Services (17 remaining)

#### Databases (6)
- [ ] **qdrant** - Vector database
- [ ] **opensearch** - Full-text search
- [ ] **sqlserver** - SQL Server
- [ ] **paradedb** - PostgreSQL with extensions
- [ ] **mongodb** - MongoDB
- [ ] **postgres** - Standard PostgreSQL (optional, not in current stack)

#### AI/ML (1)
- [ ] **sbert** - Sentence embeddings

#### Utilities (5)
- [ ] **apache-tika** - Document processing
- [ ] **pgadmin** - PostgreSQL UI
- [ ] **opensearch-dashboards** - OpenSearch UI
- [ ] **open-webui** - LLM chat interface
- [ ] **smtp4dev** - SMTP test server

#### Authentication (1)
- [ ] **keycloak** - IAM/SSO (complex: has Dockerfile + realm config + docs)

#### Messaging (2)
- [ ] **rabbitmq** - AMQP broker
- [ ] **kafka** - Event streaming

#### Cloud Emulators (2)
- [ ] **azurite** - Azure Storage emulator
- [ ] **localstack** - AWS services emulator

### 📋 RunScripts Dockerfiles (11 found, not yet migrated)

#### Dev Tools (5)
- [ ] **devbox** - Comprehensive dev environment (Node.js, .NET 9, Java, Go, Rust, Claude CLI)
- [ ] **jupyter** - Multi-kernel Jupyter Lab (Python, .NET, Java, Go, Ruby, Node.js/TypeScript)
- [ ] **tensorflow-jupyterlab** - TensorFlow + Jupyter
- [ ] **gnucobol** - GNU COBOL compiler
- [ ] **google-chrome** - Chrome with WSLg support

#### AI/ML from RunScripts (3)
- [ ] **sbert** (RunScripts version) - May differ from ContainerStore
- [ ] **sbert-cuda** - GPU-accelerated version
- [ ] **comfyui** - AI image generation

#### FPGA (2)
- [ ] **quartus** - Intel FPGA tools
- [ ] **vivado** - Xilinx FPGA tools

#### Utilities from RunScripts (1)
- [ ] **wine** - Windows app compatibility

## Migration Pattern

Each service follows this template:

```
services/[category]/[service-name]/
├── docker-compose.yml      # Standalone deployment
├── .env.template          # All configuration variables
├── README.md              # Service documentation
├── Dockerfile             # (if custom image needed)
└── [support files]        # Config files, scripts, etc.
```

### Key Requirements Per Service

1. **docker-compose.yml**
   - Standalone (can run independently)
   - Environment variable configuration
   - Proper volume definitions
   - Standard port exposure (configurable)

2. **.env.template**
   - All variables documented
   - Sensible defaults
   - Security notes

3. **README.md**
   - Service overview and type
   - Standalone usage
   - Composition examples
   - Configuration table
   - Port/volume documentation

## Next Steps

### Option A: Manual Conversion (Recommended for Quality)
Continue creating services manually following Ollama pattern:
- High quality documentation
- Proper customization per service
- ~17 services × 15 minutes = ~4-5 hours

### Option B: Semi-Automated Script
Create script to generate basic structure:
- Copy compose files
- Extract environment variables
- Generate template READMEs
- Manual review and enhancement needed

### Option C: Batch Process with Guide
Document conversion steps, convert in batches:
- Databases batch (6 services)
- Utilities batch (5 services)
- Remaining services

## After Service Conversion

### Create Example Compositions

- [ ] **examples/full-ai-ml-stack/** - All 18 services composed (main example)
- [ ] **examples/vector-search/** - Ollama + Qdrant + SBERT (RAG pattern)
- [ ] **examples/data-science/** - Jupyter + databases + visualization
- [ ] **examples/fpga-development/** - Quartus/Vivado + utilities
- [ ] **examples/microservices-dev/** - Multiple languages + databases + messaging

### Documentation Updates

- [ ] Service catalog (all services listed)
- [ ] Composition guide (how to combine services)
- [ ] Main README update
- [ ] Best practices document

## Summary

**Current:** 1 of 18 services complete (Ollama)
**Remaining:** 17 services to convert
**Additional:** 11 RunScripts Dockerfiles to add
**Total Work:** 28 services

**Architecture:** ✅ Complete and documented
**Pattern:** ✅ Proven with Ollama example
**Classification:** ✅ Corrected (by service type)

---

**Ready to proceed?** Which approach would you like:
- A) Continue manually (I'll create more examples)
- B) Semi-automated script
- C) Batch conversion guide


# Docker Image Catalog

Complete catalog of all custom Docker images in this repository.

## Status

**Total Images:** 0
**Last Updated:** 2026-01-08

## Categories

- [Development Tools](#development-tools) - Development environment images
- [Runtime Environments](#runtime-environments) - Runtime-only images
- [Databases](#databases) - Database images with extensions
- [AI/ML](#aiml) - AI/ML service images

---

## Development Tools

Custom development environment images with common tooling pre-installed.

**Total:** 0 images

*No images migrated yet. Check back after Phase 3 migration completes.*

### Planned Images

- **dotnet-sdk-full:** .NET SDK with Node.js, Azure CLI, and build tools
- **node-dev:** Node.js development environment with TypeScript and testing tools
- **python-data-science:** Python with Jupyter, pandas, numpy, scikit-learn

---

## Runtime Environments

Minimal runtime images for production deployments.

**Total:** 0 images

*No images migrated yet.*

### Planned Images

- **dotnet-runtime-slim:** Minimal .NET runtime for production
- **node-runtime:** Node.js runtime without dev dependencies

---

## Databases

Database images with useful extensions and tools pre-installed.

**Total:** 0 images

*No images migrated yet.*

### Planned Images

- **postgres-with-extensions:** PostgreSQL with pgvector, PostGIS, and other common extensions
- **sqlserver-with-tools:** SQL Server with sqlcmd, bcp, and management utilities

---

## AI/ML

Custom AI/ML service images for machine learning workflows.

**Total:** 0 images

*No images migrated yet.*

### Planned Images

- **ollama-custom:** Ollama LLM inference server with custom model configurations
- **qdrant-custom:** Qdrant vector database with optimized settings
- **sbert-custom:** Sentence-BERT embedding service with common models

---

## Image Entry Template

Use this template when adding new images to the catalog:

### image-name

| Field | Value |
|:------|:------|
| **Image Name** | outofbanddevelopment/image-name |
| **Base Image** | base-image:tag |
| **Purpose** | Brief description of image purpose |
| **Size** | [Docker image size] |
| **Platforms** | linux/amd64, linux/arm64 |
| **Tags** | latest, 1.0, 1.0.1 |

**Includes:**
- Package/tool 1 (version)
- Package/tool 2 (version)
- Additional tools

**Usage:**
```bash
docker pull outofbanddevelopment/image-name:latest
docker run -it -v $(pwd):/app -w /app outofbanddevelopment/image-name:latest bash
```

**Build Locally:**
```bash
cd images/[category]/[name]
./build.sh
```

**Source:** `images/[category]/[name]/Dockerfile`

**Migrated from:** [Original project or created new]

**Notes:** [Any special considerations, known issues, or usage tips]

---

*Last updated: 2026-01-08*
*Next review: After Phase 3 public asset migration*

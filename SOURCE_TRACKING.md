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

### Templates

#### .NET CQRS Application
- **Location:** `templates/dotnet-cqrs-app/`
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

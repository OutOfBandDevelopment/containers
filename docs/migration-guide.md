# Migration Guide

Documentation of Docker asset migration from source projects into this centralized collection.

## Migration Overview

This repository consolidates Docker assets from multiple projects into a single, well-organized collection. This guide documents:
- What was migrated
- Where it came from
- What changes were made (especially sanitization)
- Migration timeline

## Migration Phases

### Phase 1: Infrastructure ✅ COMPLETE (2026-01-08)
- [x] Created containers repository
- [x] Added as submodule at /current/src/code/public/containers
- [x] Established directory structure
- [x] Created documentation framework

### Phase 2: Asset Inventory (In Progress)
- [ ] Scan all repositories for Docker assets
- [ ] Categorize by purpose and privacy level
- [ ] Document migration priorities
- [ ] Create detailed inventory

### Phase 3: Public Asset Migration (Pending)
- [ ] Migrate RunScripts wrapper patterns
- [ ] Migrate CQRS-Examples containers
- [ ] Migrate learning project examples
- [ ] Create build automation scripts

### Phase 4: Private Asset Sanitization (Pending)
- [ ] Review ContainerStore AI/ML stack
- [ ] Sanitize all client/employer references
- [ ] Create generic .env.template files
- [ ] Migrate sanitized versions

### Phase 5: Documentation & CI/CD (Pending)
- [ ] Complete image catalog
- [ ] Complete compose catalog
- [ ] Set up GitHub Actions workflows
- [ ] Add testing automation

## Migration Sources

### Public Repositories

| Repository | Docker Assets | Status | Target Location |
|:-----------|:--------------|:-------|:----------------|
| **RunScripts** | Docker wrapper scripts | Pending | scripts/wrappers/ |
| **CQRS-Examples** | .NET microservices Dockerfile | Pending | examples/dotnet-cqrs/ |
| **YearOfCode2024** | Hybrid search examples | Pending | examples/hybrid-search/ |
| **YearOfLanguages2023** | TensorFlow examples | Pending | examples/tensorflow/ |
| **dotex** | Possible dev containers | Pending | images/dev-tools/dotnet-sdk/ |

### Private Repositories (Require Sanitization)

| Repository | Docker Assets | Status | Target Location |
|:-----------|:--------------|:-------|:----------------|
| **eliassen-ContainerStore** | 19-service AI/ML stack | Pending | compose/ai-ml-stacks/full-ai-stack/ |
| **eliassen-dotnet-libs** | .NET microservices infrastructure | Pending | compose/dev-environments/dotnet-microservices/ |
| **AnotherOneBytesTheDust** | Additional AI/ML compose files | Pending | compose/ai-ml-stacks/ |
| **Client projects** | Various patterns (heavily sanitized) | Pending | Various |

## Sanitization Protocol

All private assets undergo PII (Personally Identifiable Information) sanitization before migration.

### What is Considered PII

**Client and Employer Names:**
- Cadwell
- ERisk / Nationwide
- Eliassen
- BMW
- Chase / JPMC (JP Morgan Chase)
- Itrica
- GreenOnion
- LifeTime
- Any other client/employer names

**Sensitive Information:**
- API keys and tokens
- Database credentials
- Connection strings with real hosts
- Domain names (company-specific)
- Internal IP addresses
- Email addresses (company-specific)
- Employee names

### Sanitization Process

#### Step 1: Company Name Replacement

**In Docker Images and Compose Files:**
```yaml
# Before (private)
services:
  api:
    image: cadwell-registry/api:1.0
    environment:
      - COMPANY_NAME=Cadwell
      - DATABASE_URL=postgresql://cadwell_user:password@cadwell-db.internal:5432/production

# After (migrated)
services:
  api:
    image: outofbanddevelopment/api:1.0
    environment:
      - COMPANY_NAME=Out-of-Band Development
      - DATABASE_URL=${DATABASE_URL}
```

**In Templates for Public Use:**
```bash
# .env.template
COMPANY_NAME=YourCompany
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
```

#### Step 2: Credentials and Secrets

**Before (private):**
```yaml
environment:
  - API_KEY=sk_live_abc123xyz789
  - DB_PASSWORD=SuperSecret123!
  - SMTP_USER=notifications@cadwell.com
```

**After (migrated):**
```yaml
environment:
  - API_KEY=${API_KEY}
  - DB_PASSWORD=${DB_PASSWORD}
  - SMTP_USER=${SMTP_USER}
```

With `.env.template`:
```bash
# API Configuration
API_KEY=your-api-key-here

# Database Configuration
DB_PASSWORD=your-secure-password

# Email Configuration
SMTP_USER=notifications@example.com
```

#### Step 3: Domain Names and IPs

**Before (private):**
```yaml
services:
  app:
    environment:
      - API_URL=https://api.cadwell.internal
      - DB_HOST=10.50.20.15
```

**After (migrated):**
```yaml
services:
  app:
    environment:
      - API_URL=${API_URL}
      - DB_HOST=${DB_HOST}
```

With `.env.template`:
```bash
# API Configuration
API_URL=https://api.example.com

# Database Configuration
DB_HOST=192.168.1.10
```

#### Step 4: Comments and Documentation

**Before (private):**
```dockerfile
# Built for Cadwell medical device integration
# Contact: john.doe@cadwell.com if issues arise
```

**After (migrated):**
```dockerfile
# Medical device integration example
# Contact: See repository README for support
```

### Verification

After sanitization, run the client name scanner to verify no PII remains:

```bash
# From containers repository root
/current/src/private/client-name-scanner.sh ./

# Must exit 0 (no client names found)
# Exit 1 means PII still present - must fix before committing
```

**Scanner checks for:**
- Cadwell
- ERisk / Nationwide
- Eliassen
- BMW
- Chase / JPMC
- Itrica
- GreenOnion
- LifeTime
- Other known client/employer names

## Migration Checklist

Use this checklist when migrating assets:

### For Docker Images

- [ ] **Copy source Dockerfile** to `images/[category]/[name]/`
- [ ] **Copy related files** (.dockerignore, entrypoint scripts, configs)
- [ ] **Sanitize (if from private repo):**
  - [ ] Remove/replace company names
  - [ ] Remove hardcoded credentials
  - [ ] Replace internal domains with generic ones
  - [ ] Run scanner to verify
- [ ] **Create README.md** with purpose, usage, build instructions
- [ ] **Create build.sh** script
- [ ] **Create push.sh** script (optional)
- [ ] **Test build** locally
- [ ] **Update docs/image-catalog.md**
- [ ] **Commit with migration note**

### For Docker Compose Stacks

- [ ] **Copy docker-compose.yml** to `compose/[category]/[name]/`
- [ ] **Copy related files** (.env.example, config files, init scripts)
- [ ] **Sanitize (if from private repo):**
  - [ ] Remove/replace company names
  - [ ] Extract all credentials to environment variables
  - [ ] Create .env.template with placeholders
  - [ ] Replace internal domains/IPs
  - [ ] Run scanner to verify
- [ ] **Create README.md** with overview, setup, usage
- [ ] **Test stack** (`docker compose up -d`, verify services, cleanup)
- [ ] **Update docs/compose-catalog.md**
- [ ] **Commit with migration note**

## Migration Log

### 2026-01-08: Infrastructure Setup

**Actions:**
- Created containers repository
- Added as submodule at `/current/src/code/public/containers`
- Created directory structure:
  - `images/` (dev-tools, runtime, databases, ai-ml)
  - `compose/` (dev-environments, databases, ai-ml-stacks, utilities)
  - `scripts/` (build automation)
  - `docs/` (catalogs and guides)
  - `.github/workflows/` (CI/CD)
- Created documentation:
  - README.md
  - CLAUDE.md
  - docs/image-catalog.md
  - docs/compose-catalog.md
  - docs/best-practices.md
  - docs/migration-guide.md (this file)

**Status:** Infrastructure phase complete. Ready for asset inventory and migration.

### Future Migrations

This section will be updated as assets are migrated. Each entry will document:
- **Date:** When migrated
- **Source:** Original repository
- **Assets:** What was migrated
- **Target:** Where it was placed
- **Changes:** Sanitization applied
- **Notes:** Special considerations

Example entry format:
```markdown
### 2026-01-XX: RunScripts Wrappers

**Source:** /current/src/code/public/RunScripts
**Assets Migrated:**
- Docker wrapper scripts for 56 development tools
- Template generation system
- README documentation

**Target Location:** scripts/wrappers/

**Changes Applied:**
- Adapted wrapper patterns for generic use
- Updated documentation references
- No sanitization required (public source)

**Notes:**
- Original repository remains active
- Wrappers adapted to containers collection context
- Cross-referenced in documentation
```

## Sanitization Examples

### Example 1: ContainerStore AI/ML Stack (Future)

**Source:** `/current/src/private/repository-analysis/AnotherOneBytesTheDust/`

**Original (private):**
```yaml
# docker-compose-eliassen.yml
services:
  ollama:
    image: eliassen/ollama:latest
    environment:
      - ELIASSEN_API_KEY=sk_live_abc123
      - ADMIN_EMAIL=admin@eliassen.com
```

**Migrated (sanitized):**
```yaml
# docker-compose.yml
services:
  ollama:
    image: ollama/ollama:latest
    environment:
      - API_KEY=${API_KEY}
      - ADMIN_EMAIL=${ADMIN_EMAIL}
```

**Accompanying .env.template:**
```bash
# AI/ML Stack Configuration

# Company Name
COMPANY_NAME=YourCompany

# API Configuration
API_KEY=your-api-key-here

# Admin Configuration
ADMIN_EMAIL=admin@example.com
```

### Example 2: .NET Microservices Pattern (Future)

**Source:** Private client project

**Original (private):**
```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0
LABEL company="Cadwell"
ENV COMPANY_NAME="Cadwell" \
    API_ENDPOINT="https://api.cadwell.internal" \
    DB_PASSWORD="SuperSecret123!"
```

**Migrated (sanitized):**
```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0
LABEL maintainer="Out-of-Band Development"
ENV COMPANY_NAME="${COMPANY_NAME}" \
    API_ENDPOINT="${API_ENDPOINT}" \
    DB_PASSWORD="${DB_PASSWORD}"
```

**README.md includes .env.template:**
```bash
# Example Configuration
COMPANY_NAME=YourCompany
API_ENDPOINT=https://api.example.com
DB_PASSWORD=your-secure-password
```

## Tools and Scripts

### Client Name Scanner

Location: `/current/src/private/client-name-scanner.sh`

**Purpose:** Automatically detect client/employer names in files before commit

**Usage:**
```bash
# Scan entire directory
/current/src/private/client-name-scanner.sh ./

# Scan specific file
/current/src/private/client-name-scanner.sh ./docker-compose.yml

# Exit codes:
# 0 = No client names found (safe to commit)
# 1 = Client names found (must sanitize before commit)
```

**What it checks:**
- Cadwell, ERisk, Nationwide, Eliassen, BMW, Chase, JPMC, Itrica, GreenOnion, LifeTime
- Case-insensitive matching
- Scans file contents, not just names

### Asset Scanner

**Purpose:** Find all Docker assets across repositories

```bash
# Find Dockerfiles
find /current/src -name "Dockerfile" -not -path "*/node_modules/*" -not -path "*/.git/*"

# Find docker-compose files
find /current/src -name "docker-compose*.yml" -not -path "*/node_modules/*" -not -path "*/.git/*"

# Find .dockerignore
find /current/src -name ".dockerignore" -not -path "*/.git/*"
```

## Best Practices for Migration

1. **Always scan source first** - Understand what you're migrating before copying
2. **Document the source** - Note where assets came from in README and commit messages
3. **Test before committing** - Ensure builds/stacks work after sanitization
4. **Verify sanitization** - Run client name scanner before every commit
5. **Preserve intent** - Keep functionality while removing PII
6. **Update catalogs** - Keep documentation synchronized with repository contents
7. **Commit atomically** - One migration per commit for clear history

## Support

**Questions about migration?**
- See CLAUDE.md for detailed guidance
- Check analysis reports in `.claude/analysis/` and `private/repository-analysis/`
- Review sanitization examples in this guide

**PII concerns?**
- When in doubt, sanitize
- Run client name scanner before every commit
- See `/current/src/private/README.md` for PII protocols

---

*Created: 2026-01-08*
*Last updated: 2026-01-08*
*Next review: After Phase 2 asset inventory complete*

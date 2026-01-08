# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Repository Overview

Centralized collection of Docker containers, images, and compose stacks from all Matthew Whited projects. This repository consolidates scattered Docker assets into a single, well-documented, reusable collection.

## Repository Purpose

**Problem:** Docker assets were scattered across multiple repositories with:
- No centralized catalog
- Duplication of common patterns
- Difficulty discovering existing work
- Inconsistent documentation

**Solution:** Single repository with:
- Organized directory structure
- Comprehensive documentation
- Reusable compose stacks
- Migration tracking from source projects

## Repository Structure

```
containers/
├── images/                    # Custom Docker images (Dockerfiles)
│   ├── dev-tools/            # Development environment images
│   ├── runtime/              # Runtime-only images
│   ├── databases/            # Database images with extensions
│   └── ai-ml/                # AI/ML service images (Ollama, Qdrant, SBERT)
├── compose/                   # Docker Compose stacks
│   ├── dev-environments/     # Full-stack dev environments
│   ├── databases/            # Database management stacks
│   ├── ai-ml-stacks/         # AI/ML service combinations
│   └── utilities/            # Monitoring, management tools
├── scripts/                   # Build and management scripts
│   ├── build-all.sh          # Build all images
│   ├── push-all.sh           # Push to registry
│   ├── cleanup.sh            # Cleanup script
│   └── utils/                # Utility scripts
├── docs/                      # Documentation
│   ├── image-catalog.md      # Complete image catalog
│   ├── compose-catalog.md    # Complete compose stack catalog
│   ├── best-practices.md     # Containerization guidelines
│   └── migration-guide.md    # Migration documentation
└── .github/workflows/         # CI/CD automation
```

## Adding New Docker Images

When adding a custom Docker image:

1. **Create directory:** `images/[category]/[name]/`
   - `category`: dev-tools, runtime, databases, or ai-ml
   - `name`: descriptive image name (lowercase-with-hyphens)

2. **Add Dockerfile:**
   ```dockerfile
   FROM base-image:tag

   # Install dependencies
   RUN apt-get update && apt-get install -y \
       package1 \
       package2 \
       && rm -rf /var/lib/apt/lists/*

   # Add custom configuration
   COPY config/ /etc/config/

   # Set working directory
   WORKDIR /app

   # Entry point
   CMD ["/bin/bash"]
   ```

3. **Create README.md:**
   ```markdown
   # Image Name

   ## Purpose
   [What this image is for]

   ## Base Image
   [Base image and version]

   ## Included Tools/Packages
   - Tool 1 (version)
   - Tool 2 (version)

   ## Usage
   ```bash
   docker build -t local/image-name .
   docker run -it local/image-name
   ```

   ## Build & Push
   ```bash
   ./build.sh
   ./push.sh
   ```

   ## Tags
   - latest
   - [version]

   ## Source
   Migrated from: [original project/location]
   ```

4. **Create build.sh:**
   ```bash
   #!/bin/bash
   set -e

   IMAGE_NAME="outofbanddevelopment/image-name"
   VERSION="1.0"

   docker build -t $IMAGE_NAME:$VERSION .
   docker tag $IMAGE_NAME:$VERSION $IMAGE_NAME:latest

   echo "Built: $IMAGE_NAME:$VERSION"
   echo "Tagged: $IMAGE_NAME:latest"
   ```
   Make executable: `chmod +x build.sh`

5. **Update docs/image-catalog.md:** Add entry with specifications

6. **Test build:** `cd images/[category]/[name] && ./build.sh`

## Adding New Compose Stacks

When adding a Docker Compose stack:

1. **Create directory:** `compose/[category]/[name]/`
   - `category`: dev-environments, databases, ai-ml-stacks, or utilities
   - `name`: descriptive stack name

2. **Add docker-compose.yml:**
   ```yaml
   version: '3.8'

   services:
     service1:
       image: image:tag
       environment:
         - VAR=${ENV_VAR}
       ports:
         - "8080:8080"
       volumes:
         - ./data:/data
       networks:
         - app-network

   networks:
     app-network:
       driver: bridge

   volumes:
     data:
   ```

3. **Create .env.template:**
   ```bash
   # Service Configuration
   SERVICE_PORT=8080

   # Authentication
   API_KEY=your-api-key-here

   # Database
   DATABASE_URL=postgresql://user:password@localhost:5432/dbname

   # Company (for templates)
   COMPANY_NAME=YourCompany
   ```

4. **Create README.md:**
   ```markdown
   # Stack Name

   ## Overview
   [Description of what this stack provides]

   ## Services
   - **Service1**: Purpose and port
   - **Service2**: Purpose and port

   ## Prerequisites
   - Docker Compose v2.x
   - [Other requirements]

   ## Quick Start
   ```bash
   cd compose/[category]/[name]
   cp .env.template .env
   # Edit .env with your settings
   docker compose up -d
   ```

   ## Configuration
   [Configuration details and environment variables]

   ## Accessing Services
   - Service1: http://localhost:8080
   - Service2: http://localhost:8081

   ## Volumes
   [Persistent volume information]

   ## Source
   Migrated from: [original project/location]
   ```

5. **Update docs/compose-catalog.md:** Add stack entry

6. **Test:** `docker compose up -d && docker compose ps && docker compose down`

## Migration Protocol

When migrating Docker assets from other projects:

### Public Assets (No Sanitization Needed)

1. Identify source location
2. Copy Dockerfile/compose files to appropriate category
3. Copy related files (.dockerignore, scripts, configs)
4. Create README.md with migration source documented
5. Update appropriate catalog (image or compose)
6. Test build/deployment

### Private Assets (Sanitization Required)

**CRITICAL:** All private assets must be sanitized before migration.

**Client/Employer Names to Remove (Treat as PII):**
- Cadwell
- ERisk / Nationwide
- Eliassen
- BMW
- Chase / JPMC
- Itrica
- GreenOnion
- LifeTime
- Any other client/employer names

**Sanitization Process:**

1. **Replace company references:**
   - In code/configs: Client name → "Out-of-Band Development"
   - In templates: "Out-of-Band Development" → "YourCompany"

2. **Remove sensitive data:**
   - API keys → `${API_KEY}` with .env.template documentation
   - Credentials → Environment variables only
   - Connection strings → `${DATABASE_URL}` pattern
   - Domain names → `example.com` or `yourcompany.com`
   - Internal IPs → RFC 1918 ranges (192.168.x.x, 10.x.x.x)
   - Email addresses → `admin@example.com`

3. **Create .env.template:**
   - Document all required environment variables
   - Use generic placeholder values
   - Include comments explaining each variable

4. **Verify sanitization:**
   ```bash
   # Run client name scanner
   /current/src/private/client-name-scanner.sh ./

   # Must exit 0 (no client names found)
   ```

5. **Document migration:**
   - Note original source (without client name)
   - Document what was sanitized
   - Add entry to docs/migration-guide.md

### Migration Priority

**High Priority (Public, Easy Migration):**
1. RunScripts - Docker wrapper patterns
2. CQRS-Examples - Example Dockerfile
3. YearOfCode2024 - Hybrid search examples
4. YearOfLanguages2023 - TensorFlow examples

**Medium Priority (Private, Requires Sanitization):**
1. ContainerStore - 19-service AI/ML stack (excellent reference)
2. eliassen-dotnet-libs - .NET microservices patterns
3. Client project patterns (heavily sanitized)

**Low Priority (Complex or Deprecated):**
1. Legacy containers from old projects
2. Highly client-specific configurations

## Documentation Standards

### Image Catalog Entry Format

```markdown
### image-name

| Field | Value |
|:------|:------|
| **Image Name** | outofbanddevelopment/image-name |
| **Base Image** | base:tag |
| **Purpose** | Brief description |
| **Size** | [size] |
| **Platforms** | linux/amd64, linux/arm64 |
| **Tags** | latest, 1.0, 1.0.1 |

**Includes:**
- Package 1
- Package 2

**Usage:**
```bash
docker pull outofbanddevelopment/image-name:latest
docker run -it outofbanddevelopment/image-name:latest
```

**Source:** `images/[category]/[name]/Dockerfile`
**Migrated from:** [original project]
```

### Compose Catalog Entry Format

```markdown
### stack-name

| Field | Value |
|:------|:------|
| **Location** | compose/[category]/[name]/ |
| **Purpose** | Brief description |
| **Services** | N services |
| **GPU Support** | Yes/No |
| **Ports** | List of exposed ports |

**Services:**
- **Service1**: Purpose
- **Service2**: Purpose

**Prerequisites:**
- Requirement 1
- Requirement 2

**Quick Start:**
```bash
cd compose/[category]/[name]
cp .env.template .env
docker compose up -d
```

**Source:** [original project]
```

## Catalog Maintenance

Catalogs must stay synchronized with repository contents:

1. **When adding image:** Update `docs/image-catalog.md`
2. **When adding compose stack:** Update `docs/compose-catalog.md`
3. **Use consistent formatting:** Follow catalog entry templates above
4. **Test all examples:** Ensure commands work before documenting

## Build Automation

Build scripts should follow these patterns:

**build.sh (for images):**
```bash
#!/bin/bash
set -e

IMAGE_NAME="outofbanddevelopment/name"
VERSION="1.0"

docker build -t $IMAGE_NAME:$VERSION .
docker tag $IMAGE_NAME:$VERSION $IMAGE_NAME:latest

echo "Built: $IMAGE_NAME:$VERSION"
```

**push.sh (for images):**
```bash
#!/bin/bash
set -e

IMAGE_NAME="outofbanddevelopment/name"
VERSION="1.0"

docker push $IMAGE_NAME:$VERSION
docker push $IMAGE_NAME:latest

echo "Pushed: $IMAGE_NAME:$VERSION"
```

**scripts/build-all.sh (top-level):**
```bash
#!/bin/bash
set -e

echo "Building all images..."

for dockerfile in $(find images/ -name "Dockerfile"); do
    dir=$(dirname "$dockerfile")
    if [ -f "$dir/build.sh" ]; then
        echo "Building: $dir"
        (cd "$dir" && ./build.sh)
    fi
done

echo "All images built successfully"
```

## Testing Standards

Before committing:

1. **Images:** Build locally and verify functionality
   ```bash
   cd images/[category]/[name]
   ./build.sh
   docker run -it outofbanddevelopment/[name] --version  # or appropriate test
   ```

2. **Compose Stacks:** Start, verify services, clean up
   ```bash
   cd compose/[category]/[name]
   cp .env.template .env
   docker compose up -d
   docker compose ps  # Verify all services running
   # Test service endpoints
   docker compose down
   ```

3. **Sanitization:** Run client name scanner on private asset migrations
   ```bash
   /current/src/private/client-name-scanner.sh ./compose/[category]/[name]
   # Must exit 0 (no client names found)
   ```

## CI/CD Integration (Future)

Planned GitHub Actions workflows:

- **build-images.yml:** Build all images on push
- **test-compose.yml:** Validate compose files
- **push-images.yml:** Push images to registry on release
- **scan-security.yml:** Security scanning with Trivy

## Cross-References

**Source Projects:**
- `/current/src/code/public/RunScripts` - Docker wrapper scripts
- `/current/src/code/public/dotex` - .NET containers
- `/current/src/code/learn/CQRS-Examples` - Example application
- `/current/src/private/` - Private assets requiring sanitization

**Documentation:**
- `/current/src/shared/projects/containers-collection/` - Project documentation
- `/current/src/.claude/protocols/DOCKER_CONTAINERS_COLLECTION_PROTOCOL.md` - Complete protocol

**Analysis Reports:**
- `/current/src/.claude/analysis/RunScripts/` - RunScripts analysis
- `/current/src/.claude/analysis/eliassen-ContainerStore/` - ContainerStore analysis
- `/current/src/private/repository-analysis/` - Private project analyses

## Common Tasks

### Scan for Docker assets across all projects
```bash
find /current/src -name "Dockerfile" -not -path "*/node_modules/*" -not -path "*/.git/*"
find /current/src -name "docker-compose*.yml" -not -path "*/node_modules/*" -not -path "*/.git/*"
```

### Verify sanitization before commit
```bash
/current/src/private/client-name-scanner.sh ./
```

### Build all images
```bash
./scripts/build-all.sh
```

### Test a compose stack
```bash
cd compose/[category]/[name]
docker compose config  # Validate syntax
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

## Current Status

**Phase 1: Infrastructure** ✅ COMPLETE (2026-01-08)
- Repository created at code/public/containers
- Directory structure established
- Core documentation framework created

**Phase 2: Asset Inventory** (In Progress)
- Scanning repositories for Docker assets
- Categorizing by purpose and privacy level

**Next Steps:**
1. Complete Docker asset scan across all repositories
2. Prioritize migration candidates
3. Begin migrating public assets (RunScripts, examples)
4. Review and sanitize private assets (ContainerStore)

---

*Created: 2026-01-08*
*Last updated: 2026-01-08*
*Status: Infrastructure phase complete, asset inventory beginning*

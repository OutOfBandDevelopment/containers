# Docker Containers Style Guide

Comprehensive style guide for maintaining consistency across all Docker containers, services, and compositions in this repository.

## Document Purpose

This guide ensures:
- Consistent naming conventions
- Standardized file structures
- Uniform documentation format
- Predictable behavior across services
- Easy maintenance and updates

## File Naming Conventions

### Docker Files

```
Dockerfile               # Preferred (capital D, no extension)
docker-compose.yml       # Standard compose file
docker-compose.swarm.yml # Swarm-specific stack file
.dockerignore            # Docker ignore file
```

### Environment Files

```
.env.template            # Template with defaults and documentation
.env                     # Local configuration (gitignored)
.env.example             # Alternative to .template (less preferred)
```

### Script Files

```
start.sh / start.bat     # Start service
stop.sh / stop.bat       # Stop service
build.sh / build.bat     # Build custom images
deploy.sh / deploy.bat   # Deploy to orchestrator
```

### Documentation Files

```
README.md                # Primary documentation
ARCHITECTURE.md          # Architectural decisions
STYLE_GUIDE.md           # This document
COMPOSITION_GUIDE.md     # Composition creation guide
SOURCE_TRACKING.md       # Migration source tracking
MIGRATION_STATUS.md      # Migration progress tracking
CONSOLIDATION_LOG.md     # Service consolidation records
```

## Directory Structure

### Service Structure

```
services/[category]/[service-name]/
├── Dockerfile                 # Custom image (if needed)
├── docker-compose.yml         # Standalone deployment
├── .env.template              # Environment variables with docs
├── README.md                  # Service documentation
├── start.sh                   # Linux/macOS start script
├── start.bat                  # Windows start script
├── stop.sh                    # Linux/macOS stop script
├── stop.bat                   # Windows stop script
├── build.sh                   # Linux/macOS build script (if custom image)
├── build.bat                  # Windows build script (if custom image)
└── [config-files]/            # Service-specific configs
```

### Composition Structure

```
compositions/[composition-name]/
├── README.md                  # With PlantUML diagrams
├── docker-compose.yml         # Compose deployment
├── docker-compose.swarm.yml   # Swarm deployment
├── .env.template              # Environment configuration
├── helm/                      # Kubernetes Helm chart
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── values-dev.yaml
│   ├── values-prod.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── configmap.yaml
│       └── secrets.yaml
├── scripts/
│   ├── deploy-compose.sh/.bat
│   ├── deploy-swarm.sh/.bat
│   └── deploy-helm.sh/.bat
└── docs/
    ├── deployment-diagram.puml
    └── network-diagram.puml
```

## Naming Conventions

### Service Names

- **Directory**: lowercase-with-hyphens
- **Container**: lowercase (docker-compose `container_name`)
- **Image**: lowercase/kebab-case (e.g., `qdrant/qdrant`)

Examples:
- Directory: `opensearch-dashboards`
- Container name: `opensearch-dashboards`
- Service in compose: `opensearch-dashboards`

### Environment Variables

- **ALL_CAPS_WITH_UNDERSCORES** for all variables
- Service-specific prefix when needed

Examples:
```bash
# Good
OLLAMA_PORT=11434
POSTGRES_PASSWORD=secret
KAFKA_BROKER_ID=1

# Bad
ollamaPort=11434
postgres-password=secret
kafka.broker.id=1
```

### Volume Names

- **Service-specific prefix**
- **Purpose-based naming**
- **lowercase-with-hyphens**

Examples:
```yaml
volumes:
  mongodb-data:        # Service-specific data
  rabbitmq-log:        # Service-specific logs
  keycloak-data:       # Service-specific data
```

### Network Names

- **Purpose-based**
- **lowercase-with-hyphens**

Examples:
```yaml
networks:
  ai-ml-network:       # AI/ML services
  database-network:    # Database tier
  frontend-network:    # Frontend services
```

## Docker Compose Standards

### File Header

```yaml
name: service-name

services:
  service-name:
    image: image/name:${VERSION:-latest}
    container_name: service-name
    # ... rest of configuration
```

### Service Definition Order

1. Image or build configuration
2. Container name
3. Hostname (if needed)
4. Environment variables
5. Ports
6. Volumes
7. Networks
8. Command/entrypoint (if needed)
9. Restart policy
10. Resource limits (if needed)
11. Health checks (if needed)

Example:
```yaml
services:
  myservice:
    image: myservice:${VERSION:-latest}
    container_name: myservice
    hostname: myservice
    environment:
      - MY_VAR=${MY_VAR:-default}
    ports:
      - "${PORT:-8080}:8080"
    volumes:
      - myservice-data:/data
    networks:
      - app-network
    command: ["start", "--option"]
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### Environment Variable Defaults

Always provide defaults in docker-compose.yml:
```yaml
environment:
  - PORT=${PORT:-8080}               # Good: has default
  - DATABASE_URL=${DATABASE_URL}     # Bad: no default, will fail if missing
```

### Port Mapping

Always use environment variables for host ports:
```yaml
ports:
  - "${HOST_PORT:-8080}:8080"        # Good: configurable
  - "8080:8080"                      # Bad: hardcoded
```

### Volume Declarations

Always declare volumes at bottom:
```yaml
services:
  myservice:
    volumes:
      - myservice-data:/data

volumes:
  myservice-data:
    name: myservice-data
```

## README Documentation Standards

### Structure

Every service README must include:

1. **Title** (H1): Service name
2. **Brief description** (1 sentence)
3. **Overview** (H2): 2-3 paragraphs
4. **Features** (H2): Bullet list
5. **Quick Start** (H2): Platform-specific instructions
6. **Configuration** (H2): Table of environment variables
7. **Accessing the Service** (H2): URLs and credentials
8. **API/Usage Examples** (H2): Code examples in multiple languages
9. **Persistent Volumes** (H2): Volume descriptions
10. **Use in Compositions** (H2): Example of extending service
11. **Health Check** (H2): How to verify service is running
12. **Documentation** (H2): Links to official docs
13. **Source Tracking** (H2): Migration information
14. **Footer**: Service type, category, deployment info

**For compositions, also include:**
- **Services Overview Table** (H2): All services with ports and access info (see COMPOSITION_GUIDE.md)
- **Quick Reference Card** (H2): Credentials, health checks, volumes, resources
- **PlantUML Diagrams** (deployment and network)
- **Multi-platform Deployment** sections (Compose, Swarm, Helm)

### Configuration Table Format

```markdown
| Variable | Default | Description |
|:---------|:--------|:------------|
| SERVICE_PORT | 8080 | HTTP port |
| SERVICE_PASSWORD | changeme | Admin password (CHANGE!) |
```

### Code Examples

Include examples for at least 3 languages:
- Python
- Node.js / JavaScript
- .NET / C# or Java

Format:
````markdown
## Python Example

```python
import some_library

# Code here
```

## Node.js Example

```javascript
const library = require('library');

// Code here
```
````

### Persistent Volumes Section

Document all persistent volumes with their purpose and typical size:

```markdown
## Persistent Volumes

This service uses the following Docker volumes for persistent data:

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| mongodb-data | /data/db | Database files | 10-50GB |
| mongodb-config | /data/configdb | Configuration files | <100MB |

**Volume Descriptions:**
- **mongodb-data**: Stores all database collections, indexes, and data files
- **mongodb-config**: Contains replica set and sharding configuration

**Backup Recommendations:**
- Back up volumes regularly using `docker run --rm -v mongodb-data:/data -v $(pwd):/backup ubuntu tar czf /backup/mongodb-backup.tar.gz /data`
- Store backups offsite for disaster recovery

**Volume Management:**
```bash
# List volumes
docker volume ls | grep mongodb

# Inspect volume
docker volume inspect mongodb-data

# Remove volumes (WARNING: deletes all data)
docker compose down -v
```
```

For services without persistent volumes:

```markdown
## Persistent Volumes

This service is **stateless** and does not use persistent volumes. All data is processed in memory and discarded when the container stops.

**Note:** If you need to persist data, consider mounting a host directory:
```yaml
volumes:
  - ./data:/app/data
```
```

### Source Tracking Section

Always include at bottom:
```markdown
## Source Tracking

**Migrated from:** [repository-name]
**Source commit:** `[commit-hash]`
**Source date:** [YYYY-MM-DD]
**Source file:** `[original-file-path]`

---

**Service Type:** [Type] ([Subtype])
**Category:** [Category]
**Deployment:** [Deployment characteristics]
```

## Script Standards

### Bash Scripts (.sh)

```bash
#!/bin/bash
# Script purpose

set -e  # Exit on error

echo "=========================================="
echo "Script Action"
echo "=========================================="

# Check prerequisites
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "Please edit .env and run again"
    exit 1
fi

# Main action
docker compose up -d

echo ""
echo "Action complete!"
echo ""
echo "Next steps:"
echo "  Check status: docker compose ps"
```

### Batch Scripts (.bat)

```batch
@echo off
REM Script purpose

echo ==========================================
echo Script Action
echo ==========================================

REM Check prerequisites
if not exist .env (
    echo No .env file found. Creating from template...
    copy .env.template .env
    echo Please edit .env and run again
    exit /b 1
)

REM Main action
docker compose up -d

if errorlevel 1 (
    echo.
    echo Action failed!
    exit /b 1
)

echo.
echo Action complete!
echo.
echo Next steps:
echo   Check status: docker compose ps
```

### Script Headers

All scripts must:
- Include shebang (#!/bin/bash) for shell scripts
- Have descriptive comment at top
- Use `set -e` in bash for error handling
- Check prerequisites before executing
- Provide clear output messages
- Exit with appropriate codes (0 success, 1 failure)

## .env.template Standards

### Format

```bash
# Section Header

# Variable description
# Additional details if needed
VARIABLE_NAME=default_value

# Another variable description
ANOTHER_VARIABLE=value

# Security-sensitive variable
# IMPORTANT: Change this before deploying
PASSWORD=changeme
```

### Security Notes

For passwords and secrets:
```bash
# Admin Password
# IMPORTANT: Change this before deploying
# Requirements: At least 8 characters, uppercase, lowercase, digits, symbols
ADMIN_PASSWORD=YourStrong@Password
```

### Grouping

Group related variables:
```bash
# Ports
SERVICE_PORT=8080
ADMIN_PORT=8081

# Authentication
USERNAME=admin
PASSWORD=changeme

# Database
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=mydb
```

## PlantUML Diagram Standards

### Deployment Diagram

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Deployment.puml

title Deployment Diagram - [Composition Name]

Deployment_Node(node1, "Node 1", "Description") {
    Container(service1, "Service 1", "Technology", "Purpose")
}

Rel(service1, service2, "Relationship", "Protocol")

@enduml
```

### Network Diagram

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Network Diagram - [Composition Name]

Person(user, "User", "User description")

System_Boundary(system, "System Name") {
    Container(service1, "Service 1", "Tech", "Purpose")
}

Rel(user, service1, "Action", "Protocol:Port")

@enduml
```

## Consistency Checklist

Before committing a new service or composition:

- [ ] Follows directory structure
- [ ] Includes all required files (docker-compose, .env.template, README, scripts)
- [ ] README follows standard structure with all sections
- [ ] Environment variables use UPPER_CASE_WITH_UNDERSCORES
- [ ] Has both .sh and .bat scripts
- [ ] Scripts include error handling
- [ ] Includes source tracking information
- [ ] Volumes use named volumes with descriptive names
- [ ] Ports use environment variables for host side
- [ ] Has PlantUML diagrams (compositions only)
- [ ] Includes Helm chart (compositions only)
- [ ] All passwords default to "changeme" or similar with warning

## Common Patterns

### Requiring Configuration

```bash
# In start script
if [ ! -f .env ]; then
    echo "No .env file found. Creating from template..."
    cp .env.template .env
    echo "IMPORTANT: Edit .env and configure before starting!"
    exit 1
fi
```

### Waiting for Service

```bash
echo ""
echo "Service is starting (this may take 30-60 seconds)..."
sleep 30
```

### Success Messages

```bash
echo ""
echo "Service started successfully!"
echo ""
echo "Access points:"
echo "  Web UI: http://localhost:8080"
echo "  API:    http://localhost:8080/api"
echo ""
echo "Check status: docker compose ps"
echo "View logs:    docker compose logs -f"
echo "Stop service: ./stop.sh"
```

---

*Created: 2026-01-09*
*Version: 1.0*
*Maintained by: Matthew Whited*

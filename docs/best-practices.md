# Docker Best Practices

Guidelines and best practices for containerization used in this repository.

## General Docker Principles

### Image Building

**Use Official Base Images**
```dockerfile
# Good: Official Microsoft image
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Avoid: Unofficial or unverified images
FROM random-user/dotnet:latest
```

**Multi-Stage Builds for Production**
```dockerfile
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "App.dll"]
```

**Minimize Layer Count**
```dockerfile
# Good: Single RUN with cleanup
RUN apt-get update && apt-get install -y \
    package1 \
    package2 \
    && rm -rf /var/lib/apt/lists/*

# Avoid: Multiple RUN commands
RUN apt-get update
RUN apt-get install -y package1
RUN apt-get install -y package2
```

**Use .dockerignore**
```
# .dockerignore
node_modules/
.git/
.env
*.log
bin/
obj/
```

**Label Images Properly**
```dockerfile
LABEL maintainer="Matthew Whited <contact@outofband.dev>"
LABEL version="1.0"
LABEL description="Brief description of image purpose"
```

### Security

**Don't Run as Root**
```dockerfile
# Create non-root user
RUN addgroup --system --gid 1001 appgroup && \
    adduser --system --uid 1001 --gid 1001 appuser

# Switch to non-root user
USER appuser

WORKDIR /app
```

**Use Specific Tags, Not latest**
```dockerfile
# Good: Specific version
FROM node:20.10-alpine

# Avoid: Unpredictable updates
FROM node:latest
```

**Scan for Vulnerabilities**
```bash
# Using Docker Scout
docker scout cves outofbanddevelopment/image-name:1.0

# Using Trivy
trivy image outofbanddevelopment/image-name:1.0
```

**No Secrets in Images**
```dockerfile
# Bad: Hardcoded secrets
ENV API_KEY="sk_live_abc123"

# Good: Runtime secrets via environment
ENV API_KEY=""
# Provide via docker run -e API_KEY=...
```

### Image Optimization

**Use Alpine for Smaller Images**
```dockerfile
# Small: Alpine base (usually < 50MB)
FROM node:20-alpine

# Large: Standard base (usually > 200MB)
FROM node:20
```

**Clean Up After Installation**
```dockerfile
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
```

**Leverage Build Cache**
```dockerfile
# Copy dependency files first
COPY package.json package-lock.json ./
RUN npm install

# Then copy source code
COPY . .
```

## Docker Compose Best Practices

### Environment Configuration

**Use .env Files**
```yaml
# docker-compose.yml
services:
  app:
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - API_KEY=${API_KEY}
```

```bash
# .env (not committed)
DATABASE_URL=postgresql://user:password@db:5432/dbname
API_KEY=sk_live_abc123
```

```bash
# .env.template (committed)
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
API_KEY=your-api-key-here
```

**Environment Variable Precedence**
1. Shell environment variables
2. `.env` file in same directory as compose file
3. `environment` section in compose file
4. Dockerfile `ENV` instructions

### Service Design

**Named Volumes for Persistence**
```yaml
services:
  database:
    volumes:
      - db-data:/var/lib/postgresql/data  # Named volume

volumes:
  db-data:  # Define at top level
```

**Health Checks**
```yaml
services:
  api:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

**Resource Limits**
```yaml
services:
  app:
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 4G
        reservations:
          cpus: '0.5'
          memory: 1G
```

**Restart Policies**
```yaml
services:
  app:
    restart: unless-stopped  # Recommended for most services
    # Other options: "no", "always", "on-failure"
```

**Dependency Management**
```yaml
services:
  app:
    depends_on:
      db:
        condition: service_healthy
      cache:
        condition: service_started
```

### Network Configuration

**Custom Networks**
```yaml
services:
  frontend:
    networks:
      - public

  backend:
    networks:
      - public
      - private

  database:
    networks:
      - private

networks:
  public:
    driver: bridge
  private:
    driver: bridge
    internal: true  # No external access
```

**Port Mapping**
```yaml
services:
  app:
    ports:
      - "8080:8080"  # Host:Container
      - "127.0.0.1:8081:8081"  # Bind to localhost only
```

### Compose File Organization

**Use extends for Variants**
```yaml
# docker-compose.base.yml
services:
  app:
    image: myapp:latest
    environment:
      - NODE_ENV=${NODE_ENV}

# docker-compose.dev.yml
services:
  app:
    extends:
      file: docker-compose.base.yml
      service: app
    environment:
      - NODE_ENV=development
    volumes:
      - ./src:/app/src  # Live code reload

# docker-compose.prod.yml
services:
  app:
    extends:
      file: docker-compose.base.yml
      service: app
    environment:
      - NODE_ENV=production
    restart: always
```

**Version 3.8+ Recommended**
```yaml
version: '3.8'  # Modern syntax, good compatibility

services:
  # ...
```

## GPU Support (CUDA)

**Docker Compose with GPU**
```yaml
services:
  ollama:
    image: ollama/ollama:latest
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

**Prerequisites**
- NVIDIA GPU with CUDA support
- NVIDIA Container Toolkit installed
- Docker 19.03+ with `--gpus` support

**Testing GPU Access**
```bash
docker run --rm --gpus all nvidia/cuda:12.0-base nvidia-smi
```

## Development vs Production

### Development Configuration
```yaml
# docker-compose.dev.yml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - ./src:/app/src  # Live code reload
      - /app/node_modules  # Preserve container node_modules
    environment:
      - NODE_ENV=development
      - DEBUG=app:*
    ports:
      - "8080:8080"  # Direct port mapping for debugging
```

### Production Configuration
```yaml
# docker-compose.prod.yml
services:
  app:
    image: outofbanddevelopment/app:1.0  # Pre-built image
    environment:
      - NODE_ENV=production
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 2G
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

## Logging

**Structured Logging**
```yaml
services:
  app:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        labels: "service,environment"
```

**View Logs**
```bash
# All services
docker compose logs

# Specific service
docker compose logs app

# Follow logs
docker compose logs -f app

# Last 100 lines
docker compose logs --tail=100 app
```

## Common Patterns

### Database Initialization
```yaml
services:
  postgres:
    image: postgres:16-alpine
    environment:
      - POSTGRES_DB=appdb
      - POSTGRES_USER=appuser
      - POSTGRES_PASSWORD=${DB_PASSWORD}
    volumes:
      - db-data:/var/lib/postgresql/data
      - ./init-scripts:/docker-entrypoint-initdb.d  # Auto-run on first start
```

### Wait-for-it Pattern
```yaml
services:
  app:
    depends_on:
      db:
        condition: service_healthy
    command: >
      sh -c "
        /wait-for-it.sh db:5432 --timeout=30 --strict --
        node server.js
      "
```

### Reverse Proxy (Traefik Example)
```yaml
services:
  traefik:
    image: traefik:v2.10
    command:
      - "--api.insecure=true"
      - "--providers.docker=true"
    ports:
      - "80:80"
      - "8080:8080"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

  app:
    image: myapp:latest
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.app.rule=Host(`app.localhost`)"
```

## Testing Containers

**Test Image Build**
```bash
docker build -t test-image .
docker run --rm test-image /bin/sh -c "command --version"
```

**Test Compose Stack**
```bash
# Validate syntax
docker compose config

# Start services
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs

# Test endpoints
curl http://localhost:8080/health

# Cleanup
docker compose down
docker compose down -v  # Also remove volumes
```

**Automated Testing**
```bash
#!/bin/bash
set -e

echo "Starting services..."
docker compose up -d

echo "Waiting for services to be healthy..."
sleep 10

echo "Testing API endpoint..."
curl -f http://localhost:8080/health || exit 1

echo "Tests passed!"
docker compose down
```

## Maintenance

**Cleanup Old Images**
```bash
docker image prune -a
```

**Cleanup Volumes**
```bash
docker volume prune
```

**Cleanup Everything**
```bash
docker system prune -a --volumes
```

**Check Disk Usage**
```bash
docker system df
```

---

*Last updated: 2026-01-08*
*Next review: When adding new patterns or encountering new challenges*

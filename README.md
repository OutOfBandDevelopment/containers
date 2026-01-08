# Docker Containers Collection

Centralized repository for all Docker images, compose stacks, and containerization utilities from Matthew Whited's projects.

## Quick Navigation

- **[Image Catalog](docs/image-catalog.md)** - All custom Docker images
- **[Compose Catalog](docs/compose-catalog.md)** - All Docker Compose stacks
- **[Best Practices](docs/best-practices.md)** - Containerization guidelines
- **[Migration Guide](docs/migration-guide.md)** - How assets were migrated

## Repository Structure

```
containers/
├── images/                    # Custom Docker images
│   ├── dev-tools/            # Development environment images
│   ├── runtime/              # Runtime-only images
│   ├── databases/            # Database images with extensions
│   └── ai-ml/                # AI/ML service images
├── compose/                   # Docker Compose stacks
│   ├── dev-environments/     # Full-stack development environments
│   ├── databases/            # Database management stacks
│   ├── ai-ml-stacks/         # AI/ML service stacks
│   └── utilities/            # Utility stacks (monitoring, portainer)
├── scripts/                   # Container management scripts
│   ├── build-all.sh          # Build all images
│   ├── push-all.sh           # Push all images
│   ├── cleanup.sh            # Cleanup script
│   └── utils/                # Utility scripts
├── docs/                      # Documentation
│   ├── image-catalog.md      # Image catalog
│   ├── compose-catalog.md    # Compose stack catalog
│   ├── best-practices.md     # Best practices
│   └── migration-guide.md    # Migration documentation
└── .github/workflows/         # CI/CD workflows
```

## Quick Start

### Using a Docker Compose Stack

```bash
cd compose/ai-ml-stacks/[stack-name]
cp .env.template .env
# Edit .env with your settings
docker compose up -d
```

### Building a Custom Image

```bash
cd images/[category]/[name]
./build.sh
```

## Categories

### Development Tools (images/dev-tools/)
Custom development environment images with common tooling
- .NET SDK with Node.js and Azure CLI
- Node.js development environments
- Python data science environments

### Runtime Environments (images/runtime/)
Minimal runtime images for production deployments
- .NET Runtime
- Node.js Runtime

### Databases (images/databases/)
Database images with useful extensions pre-installed
- PostgreSQL with common extensions
- SQL Server with management tools

### AI/ML Images (images/ai-ml/)
Custom AI/ML service images
- Ollama (LLM inference)
- Qdrant (vector database)
- SBERT (sentence embeddings)

### Development Environment Stacks (compose/dev-environments/)
Complete development environments with all services
- .NET Full-stack (API + DB + Frontend)
- Node + React stack
- Python data science stack

### Database Stacks (compose/databases/)
Database management environments
- PostgreSQL + pgAdmin
- SQL Server + Management Studio

### AI/ML Stacks (compose/ai-ml-stacks/)
Production-ready AI/ML service combinations
- Ollama + Qdrant (LLM + Vector DB)
- SBERT + OpenSearch (Embeddings + Search)
- Full AI Stack (19 services with GPU support)

### Utility Stacks (compose/utilities/)
Management and monitoring tools
- Portainer (container management)
- Monitoring stack (Prometheus + Grafana)

## Project Origins

This repository consolidates Docker assets from multiple projects:

**Public Sources:**
- **RunScripts** - Docker wrapper scripts for development tools
- **CQRS-Examples** - CQRS/Event Sourcing example containers
- **YearOfCode2024** - Hybrid search learning projects
- **YearOfLanguages2023** - TensorFlow examples
- **dotex** - .NET development containers

**Private Sources (Sanitized):**
- **ContainerStore** - 19-service AI/ML development stack
- **eliassen-dotnet-libs** - .NET microservices infrastructure
- Various client projects (all references sanitized)

All private sources have been sanitized according to PII protection protocols. See `docs/migration-guide.md` for details.

## Migration Status

**Phase 1: Infrastructure** ✅ COMPLETE
- [x] Repository created and added as submodule
- [x] Directory structure established
- [x] Documentation framework created

**Phase 2: Asset Inventory** (In Progress)
- [ ] Scan all repositories for Docker assets
- [ ] Categorize by purpose and privacy level
- [ ] Document migration priorities

**Phase 3: Public Asset Migration** (Pending)
- [ ] Migrate RunScripts wrapper patterns
- [ ] Migrate CQRS-Examples containers
- [ ] Migrate learning project examples
- [ ] Create build automation scripts

**Phase 4: Private Asset Sanitization** (Pending)
- [ ] Review ContainerStore AI/ML stack
- [ ] Sanitize all client/employer references
- [ ] Create generic .env.template files
- [ ] Migrate sanitized versions

**Phase 5: Documentation & CI/CD** (Pending)
- [ ] Complete image catalog
- [ ] Complete compose catalog
- [ ] Set up GitHub Actions workflows
- [ ] Add testing automation

## Contributing

When adding new containers to this repository:

1. **Images:** Place in appropriate `images/` subdirectory
2. **Documentation:** Create README.md with purpose, usage, and build instructions
3. **Build Scripts:** Include `build.sh` and optional `push.sh`
4. **Catalog Entry:** Update `docs/image-catalog.md`

When adding compose stacks:

1. **Location:** Place in appropriate `compose/` subdirectory
2. **Configuration:** Include `.env.template` with all required variables
3. **Documentation:** Create README.md with setup and usage instructions
4. **Catalog Entry:** Update `docs/compose-catalog.md`

## Sanitization Requirements

All assets migrated from private repositories must follow sanitization protocols:

**Client/Employer Names (Treat as PII):**
- Cadwell, ERisk, Nationwide, Eliassen, BMW, Chase, JPMC, Itrica, GreenOnion, LifeTime
- **Replace with:** "Out-of-Band Development" (in migrated code)
- **Template placeholder:** "YourCompany" (in .env.template and examples)

**Sensitive Data:**
- API keys → `${API_KEY}` with documentation in .env.template
- Credentials → Environment variables only
- Domain names → `example.com` or `yourcompany.com`
- Internal IPs → RFC 1918 ranges (192.168.x.x)

See `docs/migration-guide.md` for complete sanitization procedures.

## License

MIT License

Copyright (c) 2026 Matthew Whited / Out-of-Band Development

See LICENSE file for details.

## Related Projects

- **[dotex](https://github.com/OutOfBandDevelopment/dotex)** - .NET extensions framework
- **[RunScripts](https://github.com/OutOfBandDevelopment/RunScripts)** - Docker wrapper framework
- **[BinaryDataDecoders](https://github.com/mwwhited/BinaryDataDecoders)** - Data encoding/decoding libraries

## Contact

**GitHub:** [@mwwhited](https://github.com/mwwhited)
**Organization:** [OutOfBandDevelopment](https://github.com/OutOfBandDevelopment)

---

*Last updated: 2026-01-08*
*Status: Infrastructure phase complete, asset inventory in progress*

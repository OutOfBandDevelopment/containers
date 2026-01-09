# Container Templates

Reusable templates for creating new services and applications.

## .dockerignore Templates

### .dockerignore.dotnet
Standard .dockerignore for .NET projects.

**Usage:**
```bash
cp templates/.dockerignore.dotnet /path/to/project/.dockerignore
```

## Application Templates

### dotnet-cqrs-app
Template for .NET applications using CQRS (Command Query Responsibility Segregation) pattern.

**Contains:**
- Multi-stage Dockerfile for .NET 7.0 Web API
- .dockerignore optimized for .NET
- README with build instructions

**Usage:**
```bash
cp -r templates/dotnet-cqrs-app /path/to/new-project
cd /path/to/new-project
# Modify for your application
```

**Pattern:** Multi-stage build (SDK → Runtime) for minimal production image

**Source:** Migrated from code/learn/CQRS-Examples

## Service Templates

### service-template (Coming Soon)
Complete template for creating new containerized services.

Will include:
- Dockerfile.template
- docker-compose.yml.template
- .env.template.template
- README.md.template

## Future Templates

- `.dockerignore.python` - Python projects
- `.dockerignore.node` - Node.js projects
- `dotnet-microservice` - .NET microservice template
- `python-flask-api` - Flask API template
- `node-express-api` - Express API template

## Using Templates

1. **Copy template to your project:**
   ```bash
   cp -r templates/template-name /your/project/path
   ```

2. **Customize for your needs:**
   - Update names and ports
   - Modify environment variables
   - Adjust for your application structure

3. **Test:**
   ```bash
   docker compose up -d
   ```

---

*Templates are starting points - customize them for your specific needs*

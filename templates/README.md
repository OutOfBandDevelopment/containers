# Docker Templates

Standard Docker configuration templates for various project types.

## .dockerignore Templates

### .dockerignore.dotnet

Standard .dockerignore for .NET projects. Excludes:
- Build outputs (bin/, obj/)
- IDE files (.vs/, .vscode/, *.user)
- Git repository (.git/)
- Environment files (.env, secrets)
- Documentation (LICENSE, README.md)
- Node modules (for hybrid projects)

**Usage:**
```bash
cp templates/.dockerignore.dotnet /path/to/project/.dockerignore
```

**Source:** Migrated from code/learn/CQRS-Examples

### Future Templates

Additional templates to be added:
- `.dockerignore.node` - Node.js projects
- `.dockerignore.python` - Python projects
- `.dockerignore.go` - Go projects

## Dockerfile Templates

Future additions for common Dockerfile patterns:
- Multi-stage .NET builds
- Node.js development and production
- Python data science environments
- Go microservices

## Contributing

When adding new templates:
1. Name with appropriate extension (`.template` or `.{language}`)
2. Include comments explaining each section
3. Update this README with usage instructions
4. Document the source/migration origin

---

*Created: 2026-01-09*
*Templates migrated from public project examples*

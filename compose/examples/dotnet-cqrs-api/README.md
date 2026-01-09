# .NET CQRS API Example

## Overview

Example Dockerfile for a .NET 7.0 Web API implementing CQRS (Command Query Responsibility Segregation) and Event Sourcing patterns.

## Base Images

- **Runtime:** mcr.microsoft.com/dotnet/aspnet:7.0
- **Build:** mcr.microsoft.com/dotnet/sdk:7.0

## Purpose

Demonstrates a multi-stage Docker build for a .NET CQRS application:
- Minimal production image using ASP.NET runtime
- Separate build stage using full SDK
- Optimized layer caching with restore before copy

## Build

```bash
# From the source directory containing ExampleApp.WebApi/
docker build -t local/cqrs-api:latest -f Dockerfile .
```

## Run

```bash
docker run -p 8080:80 local/cqrs-api:latest
```

Access the API at: http://localhost:8080

## Multi-Stage Build Explanation

1. **base** - Runtime environment (ASP.NET Core)
2. **build** - Restore and build the application
3. **publish** - Create publishable output
4. **final** - Copy published files to runtime image

## Project Structure Requirements

This Dockerfile expects:
```
/src/
  ExampleApp.WebApi/
    ExampleApp.WebApi.csproj
    [other source files]
```

Adjust the `COPY` paths if your project structure differs.

## Source

Migrated from: [CQRS-Examples](https://github.com/mwwhited/CQRS-Examples)

## Related Examples

- Full CQRS application in code/learn/CQRS-Examples
- Multi-service CQRS architecture with event sourcing
- See `.claude/analysis/CQRS-Examples/` for detailed analysis

## Tags

- .NET 7.0
- ASP.NET Core
- CQRS
- Event Sourcing
- Multi-stage build
- Example application

---

*Migrated: 2026-01-09*
*Source: code/learn/CQRS-Examples*

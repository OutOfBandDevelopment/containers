# Generic .NET Application Docker Template

Reusable Docker template for any .NET application with multi-stage build pattern.

## Overview

This template works with **any .NET project** by accepting the project name and assembly as parameters. No hardcoded project names - fully customizable via build scripts.

## Usage

### Quick Start

**Linux/macOS:**
```bash
# Copy template to your project
cp -r templates/dotnet-app/* /path/to/your-dotnet-project/

# Build with your project name
cd /path/to/your-dotnet-project
./build.sh YourApp.WebApi YourApp.WebApi 8.0 yourapp:latest
```

**Windows:**
```cmd
REM Copy template to your project
xcopy /E /I templates\dotnet-app\* C:\path\to\your-dotnet-project\

REM Build with your project name
cd C:\path\to\your-dotnet-project
build.bat YourApp.WebApi YourApp.WebApi 8.0 yourapp:latest
```

### Build Script Parameters

```bash
./build.sh <project-name> [dll-name] [dotnet-version] [image-tag]
```

| Parameter | Required | Default | Description |
|:----------|:---------|:--------|:------------|
| project-name | Yes | - | .csproj name without extension |
| dll-name | No | Same as project-name | Output DLL name (usually same) |
| dotnet-version | No | 8.0 | .NET version (7.0, 8.0, 9.0) |
| image-tag | No | project-name:latest | Docker image tag |

### Examples

**Simple Web API:**
```bash
./build.sh MyCompany.Api
# Uses: MyCompany.Api.csproj, MyCompany.Api.dll, .NET 8.0, mycompany.api:latest
```

**Specify all parameters:**
```bash
./build.sh MyCompany.Api MyCompany.Api 8.0 mycompany-api:v1.0
```

**Different .NET versions:**
```bash
# .NET 7.0
./build.sh MyApp MyApp 7.0 myapp:net7

# .NET 9.0
./build.sh MyApp MyApp 9.0 myapp:net9
```

## Dockerfile Build Args

The Dockerfile accepts these build arguments:

| Argument | Purpose | Example |
|:---------|:--------|:--------|
| DOTNET_VERSION | .NET SDK/Runtime version | 8.0, 7.0, 9.0 |
| PROJECT_NAME | Project/csproj name | MyApp.WebApi |
| DLL_NAME | Output assembly name | MyApp.WebApi |
| PROJECT_PATH | Path to project (if not in root) | ./src/MyApp |

## Project Structure Requirements

This template expects:

```
your-project/
├── YourApp.csproj          # Your project file
├── Program.cs              # Your source files
├── [other .cs files]
├── Dockerfile              # This template
├── .dockerignore           # Included in template
├── build.sh               # Build script (Linux/macOS)
└── build.bat              # Build script (Windows)
```

## Multi-Stage Build Explanation

This Dockerfile uses a 4-stage build:

1. **base** - Runtime environment (ASP.NET Core)
2. **build** - Restore and build
3. **publish** - Create publishable output
4. **final** - Runtime with published app

**Benefits:**
- Small final image (runtime only, no SDK)
- Efficient layer caching
- Fast rebuilds

## Pattern Source

**Based on:** code/learn/CQRS-Examples
**Generalized:** 2026-01-09
**Purpose:** Reusable template for any .NET application

---

**Template Type:** Application Docker Template
**Technology:** .NET (any version)
**Pattern:** Multi-stage build

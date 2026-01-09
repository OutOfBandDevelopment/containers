# .NET Development Container

Lightweight .NET development environment with SDK and essential tools.

## Overview

Minimal .NET container for C#/F# development. Based on official Microsoft .NET SDK images with persistent workspace and NuGet cache. Perfect for .NET projects without multi-language overhead.

## Features

- **Official .NET SDK**: Latest .NET 9.0 by default
- **dotnet CLI**: Complete toolchain
- **Persistent workspace**: Projects preserved across restarts
- **NuGet cache**: Faster package restoration
- **Interactive shell**: Direct bash access
- **Telemetry disabled**: Privacy-focused

## Quick Start

```bash
cd services/dev-tools/dev-dotnet
./start.sh

# Inside container:
dotnet --version
dotnet new console -n MyApp
cd MyApp && dotnet run
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| DOTNET_VERSION | 9.0 | .NET SDK version |

## Usage Examples

### Console Application

```bash
dotnet new console -n HelloWorld
cd HelloWorld
dotnet run
```

### Web API

```bash
dotnet new webapi -n MyApi
cd MyApi
dotnet run
```

### Class Library

```bash
dotnet new classlib -n MyLibrary
cd MyLibrary
dotnet build
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| dotnet-workspace | /workspace | Project files | 1-10GB |
| dotnet-nuget | /root/.nuget | NuGet package cache | 1-5GB |

## Documentation

- **.NET**: https://learn.microsoft.com/en-us/dotnet/

---

**Service Type:** Development Tool (.NET)
**Category:** dev-tools
**Deployment:** Uses official .NET SDK image

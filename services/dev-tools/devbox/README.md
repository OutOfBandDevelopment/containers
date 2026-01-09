# DevBox

Comprehensive polyglot development environment with Node.js, .NET, Java, Go, Rust, PlatformIO, and Claude Code CLI in a single container.

## Overview

DevBox is an all-in-one development container that provides a complete multi-language development environment. It eliminates the need to install and manage multiple language runtimes and SDKs on your host system. Perfect for polyglot development, CI/CD environments, or experimenting with different programming languages without polluting your local environment.

The container includes the latest LTS/stable versions of popular programming languages and development tools, along with PlatformIO for embedded development and the Claude Code CLI for AI-assisted coding. All package managers and tools are pre-configured and ready to use.

Ideal for development teams that need consistent environments across machines, cloud-based development workflows, or developers who work across multiple programming languages and don't want to manage local installations.

## Features

- **Node.js (LTS)**: JavaScript/TypeScript development with npm
- **.NET 9.0 SDK**: C#/F# development with full SDK
- **Java 21**: Modern Java development with OpenJDK
- **Go (configurable version)**: Go development with modules support
- **Rust**: Latest stable Rust with Cargo package manager
- **PlatformIO**: Embedded development for Arduino, ESP32, STM32, etc.
- **Claude Code CLI**: AI-assisted development with Anthropic's Claude
- **Python 3**: Pre-installed for scripting and tooling
- **Git**: Version control included
- **Build tools**: GCC, make, and essential build utilities
- **Persistent package caches**: npm, NuGet, Go modules, Cargo cached across runs
- **Interactive shell**: Direct bash access for command-line workflows

## Quick Start

### Linux/macOS

```bash
cd services/dev-tools/devbox

# Build the custom image (first time, or after Dockerfile changes)
./build.sh

# Start interactive shell
./start.sh

# You'll be dropped into a bash shell with all tools available
# Exit the shell to stop the container
```

### Windows

```batch
cd services\dev-tools\devbox

REM Build the custom image (first time, or after Dockerfile changes)
build.bat

REM Start interactive shell
start.bat

REM You'll be dropped into a bash shell with all tools available
REM Exit the shell to stop the container
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| DEVBOX_VERSION | latest | Image version/tag |
| GO_VERSION | 1.23.5 | Go language version (build-time) |

Edit `.env` after copying from `.env.template` to customize these values. Note that `GO_VERSION` requires a rebuild to take effect.

## Accessing the Service

This is an **interactive container** that runs a bash shell. Use `docker compose run` or `docker exec` to access it:

**Start interactive session:**
```bash
docker compose run --rm devbox
```

**Or with the start script:**
```bash
./start.sh  # Automatically runs docker compose run
```

**Execute single command:**
```bash
docker compose run --rm devbox node --version
docker compose run --rm devbox dotnet --version
docker compose run --rm devbox java --version
```

## Usage Examples

### Node.js Development

```bash
# Inside the container
node --version
npm --version

# Create a Node.js project
mkdir my-node-app && cd my-node-app
npm init -y
npm install express

# Create index.js
cat > index.js << 'EOF'
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello from DevBox!'));
app.listen(3000, () => console.log('Server running on port 3000'));
EOF

# Run the application
node index.js
```

### .NET Development

```bash
# Inside the container
dotnet --version

# Create a console application
dotnet new console -n MyApp
cd MyApp
dotnet run
```

### Java Development

```bash
# Inside the container
java --version
javac --version

# Create a simple Java program
cat > HelloWorld.java << 'EOF'
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello from DevBox!");
    }
}
EOF

# Compile and run
javac HelloWorld.java
java HelloWorld
```

### Go Development

```bash
# Inside the container
go version

# Create a Go module
mkdir my-go-app && cd my-go-app
go mod init example.com/hello

# Create main.go
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello from DevBox!")
}
EOF

# Run the application
go run main.go
```

### Rust Development

```bash
# Inside the container
rustc --version
cargo --version

# Create a new Rust project
cargo new my-rust-app
cd my-rust-app
cargo run
```

### PlatformIO (Embedded Development)

```bash
# Inside the container
pio --version

# Create a new project for Arduino Uno
pio project init --board uno

# List available boards
pio boards

# Upload to device (requires device mounted)
pio run --target upload
```

### Claude Code CLI

```bash
# Inside the container
claude --version

# Initialize Claude Code in a project
claude init

# Start coding with AI assistance
claude code
```

### Multi-Language Project

```bash
# Example: Polyglot microservices project
mkdir polyglot-services && cd polyglot-services

# Create Node.js service
mkdir api-gateway && cd api-gateway
npm init -y
npm install express
# ... develop Node.js API ...
cd ..

# Create .NET service
dotnet new webapi -n UserService
# ... develop .NET service ...

# Create Go service
mkdir product-service && cd product-service
go mod init example.com/products
# ... develop Go service ...
cd ..

# Create Rust service
cargo new order-service
# ... develop Rust service ...
```

## Persistent Volumes

This service uses the following Docker volumes for persistent data:

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| devbox-workspace | /workspace | Project files and source code | 5-50GB |
| devbox-dotnet | /root/.dotnet | .NET SDK and tools | 500MB-2GB |
| devbox-nuget | /root/.nuget | NuGet package cache | 1-5GB |
| devbox-go | /go | Go modules and packages | 500MB-5GB |
| devbox-cargo | /root/.cargo | Rust packages and registry | 1-10GB |
| devbox-npm | /root/.npm | npm package cache | 500MB-5GB |
| devbox-platformio | /root/.platformio | PlatformIO packages and boards | 1-5GB |

**Volume Descriptions:**
- **devbox-workspace**: Your project files, source code, and working directory
- **devbox-dotnet**: .NET tools, global packages, and SDK components
- **devbox-nuget**: Downloaded NuGet packages (shared across .NET projects)
- **devbox-go**: Go modules, packages, and build cache (GOPATH)
- **devbox-cargo**: Rust crates registry and compiled dependencies
- **devbox-npm**: npm global packages and download cache
- **devbox-platformio**: Embedded development boards, toolchains, and libraries

**Backup Recommendations:**
- Back up devbox-workspace regularly to preserve your source code
- Package cache volumes can be rebuilt by package managers

**Volume Management:**
```bash
# List volumes
docker volume ls | grep devbox

# Inspect workspace volume
docker volume inspect devbox-workspace

# Backup workspace
docker run --rm -v devbox-workspace:/data -v $(pwd):/backup ubuntu tar czf /backup/devbox-workspace-backup.tar.gz /data

# Remove volumes (WARNING: deletes all projects and caches)
docker compose down -v
```

## Use in Compositions

To use this service in a composition with `extends`:

```yaml
services:
  devbox:
    extends:
      file: ../../services/dev-tools/devbox/docker-compose.yml
      service: devbox
    networks:
      - dev-network
    # Mount additional project directories
    volumes:
      - ./my-project:/workspace/my-project
```

## Health Check

Check if DevBox is available and tools are working:

```bash
# Check that the image exists
docker images | grep devbox

# Run version checks for all tools
docker compose run --rm devbox bash -c "
  echo 'Node.js:' && node --version &&
  echo '.NET:' && dotnet --version &&
  echo 'Java:' && java --version &&
  echo 'Go:' && go version &&
  echo 'Rust:' && rustc --version &&
  echo 'PlatformIO:' && pio --version &&
  echo 'Claude:' && claude --version &&
  echo 'All tools operational!'
"
```

**Expected healthy state:**
- All version commands return successfully
- No errors in tool initialization

## Documentation

- **Node.js**: https://nodejs.org/docs/
- **.NET**: https://learn.microsoft.com/en-us/dotnet/
- **Java**: https://docs.oracle.com/en/java/
- **Go**: https://go.dev/doc/
- **Rust**: https://doc.rust-lang.org/
- **PlatformIO**: https://docs.platformio.org/
- **Claude Code**: https://docs.anthropic.com/en/docs/claude-code/

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.devbox`

**Build from:** Custom Dockerfile (Ubuntu base with multi-language runtime installation)

---

**Service Type:** Development Tool (Polyglot IDE Environment)
**Category:** dev-tools
**Deployment:** Requires custom image build, runs interactively

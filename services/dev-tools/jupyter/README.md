# Jupyter Lab (Multi-Kernel)

Multi-language Jupyter Lab environment with support for Python, .NET, Java, Go, Ruby, and TypeScript/JavaScript notebooks.

## Overview

This service provides a comprehensive Jupyter Lab environment with multiple programming language kernels. It's ideal for data science, machine learning experimentation, and polyglot development workflows. The environment includes popular ML libraries like PyTorch and TensorFlow pre-installed with the Python kernel.

Unlike standard Jupyter installations that only support Python, this image includes fully functional kernels for six programming languages, allowing you to write and execute notebooks in Python, C#/.NET, Java, Go, Ruby, or TypeScript/JavaScript within the same Jupyter Lab interface.

Perfect for educational settings, data science teams, or any workflow requiring multi-language notebook support in a single containerized environment.

## Features

- **Multi-kernel support**: Python, .NET Interactive, Java (IJava), Go (gonb), Ruby (iruby), TypeScript/JavaScript (tslab)
- **ML libraries pre-installed**: PyTorch, TensorFlow (CPU)
- **Python 3.10**: Latest stable Python with debugging symbols
- **.NET SDK 8.0**: Full .NET development environment with interactive kernel
- **Java 21**: OpenJDK 21 with IJava kernel
- **Go**: Latest Go compiler with gonb kernel and language server
- **Ruby 3.0**: Ruby development with iruby kernel
- **Node.js/TypeScript**: TypeScript and JavaScript kernel support
- **Persistent workspace**: Notebooks and files preserved across container restarts
- **No authentication by default**: Easy local development (configurable for production)
- **Web-based interface**: Access via browser at http://localhost:8888

## Quick Start

### Linux/macOS

```bash
cd services/dev-tools/jupyter

# Build the custom image (first time, or after Dockerfile changes)
./build.sh

# Start Jupyter Lab
./start.sh

# Access Jupyter Lab at http://localhost:8888

# Stop Jupyter Lab
./stop.sh
```

### Windows

```batch
cd services\dev-tools\jupyter

REM Build the custom image (first time, or after Dockerfile changes)
build.bat

REM Start Jupyter Lab
start.bat

REM Access Jupyter Lab at http://localhost:8888

REM Stop Jupyter Lab
stop.bat
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| JUPYTER_VERSION | latest | Image version/tag |
| JUPYTER_PORT | 8888 | Web interface port |
| JUPYTER_ENABLE_LAB | yes | Enable Jupyter Lab interface |

Edit `.env` after copying from `.env.template` to customize these values.

## Accessing the Service

**Jupyter Lab Interface**: http://localhost:8888

**No authentication required** (default configuration for local development).

For production use, you should configure authentication by modifying the Dockerfile's ENTRYPOINT or setting up Jupyter Lab password/token in the container.

## Usage Examples

### Create Python Notebook

1. Open http://localhost:8888
2. Click "Python 3" under "Notebook"
3. Write Python code:

```python
import torch
import tensorflow as tf

# PyTorch example
x = torch.rand(5, 3)
print("PyTorch tensor:", x)

# TensorFlow example
y = tf.constant([[1.0, 2.0], [3.0, 4.0]])
print("TensorFlow tensor:", y)
```

### Create .NET Notebook

1. Open http://localhost:8888
2. Click ".NET (C#)" under "Notebook"
3. Write C# code:

```csharp
using System;
using System.Linq;

var numbers = Enumerable.Range(1, 10).ToArray();
Console.WriteLine($"Sum: {numbers.Sum()}");

// Display result
numbers
```

### Create Java Notebook

1. Open http://localhost:8888
2. Click "Java" under "Notebook"
3. Write Java code:

```java
import java.util.stream.IntStream;

var sum = IntStream.rangeClosed(1, 10).sum();
System.out.println("Sum: " + sum);

return sum;
```

### Create Go Notebook

1. Open http://localhost:8888
2. Click "Go (gonb)" under "Notebook"
3. Write Go code:

```go
package main

import "fmt"

func main() {
    sum := 0
    for i := 1; i <= 10; i++ {
        sum += i
    }
    fmt.Printf("Sum: %d\n", sum)
}
```

### Create Ruby Notebook

1. Open http://localhost:8888
2. Click "Ruby" under "Notebook"
3. Write Ruby code:

```ruby
numbers = (1..10).to_a
sum = numbers.sum

puts "Sum: #{sum}"
sum
```

### Create TypeScript Notebook

1. Open http://localhost:8888
2. Click "TypeScript" under "Notebook"
3. Write TypeScript code:

```typescript
const numbers: number[] = Array.from({length: 10}, (_, i) => i + 1);
const sum = numbers.reduce((a, b) => a + b, 0);

console.log(`Sum: ${sum}`);
sum;
```

## Persistent Volumes

This service uses the following Docker volumes for persistent data:

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| jupyter-workspace | /workspace | Notebook files and workspace | 1-10GB |
| jupyter-dotnet | /root/.dotnet | .NET tools and packages | 500MB-2GB |
| jupyter-go | /go | Go packages and modules | 500MB-2GB |
| jupyter-ruby | /root/.local/share/gem | Ruby gems | 100MB-500MB |
| jupyter-npm | /root/.npm | npm packages cache | 100MB-1GB |

**Volume Descriptions:**
- **jupyter-workspace**: Stores all your notebook files (.ipynb), data files, and workspace content
- **jupyter-dotnet**: Contains .NET Interactive tools and NuGet package cache
- **jupyter-go**: Stores Go GOPATH with installed packages and build cache
- **jupyter-ruby**: Ruby gems installed with --user-install flag
- **jupyter-npm**: npm global packages and cache

**Backup Recommendations:**
- Back up jupyter-workspace regularly to preserve your notebooks
- Other volumes can be rebuilt by reinstalling packages

**Volume Management:**
```bash
# List volumes
docker volume ls | grep jupyter

# Inspect workspace volume
docker volume inspect jupyter-workspace

# Backup notebooks
docker run --rm -v jupyter-workspace:/data -v $(pwd):/backup ubuntu tar czf /backup/jupyter-notebooks-backup.tar.gz /data

# Remove volumes (WARNING: deletes all notebooks and packages)
docker compose down -v
```

## Use in Compositions

To use this service in a composition with `extends`:

```yaml
services:
  jupyter:
    extends:
      file: ../../services/dev-tools/jupyter/docker-compose.yml
      service: jupyter
    networks:
      - dev-network
    # Override port if needed
    ports:
      - "8889:8888"
```

## Health Check

Check if Jupyter Lab is running:

```bash
# Check container status
docker compose ps

# Check logs
docker compose logs jupyter

# Test web interface
curl http://localhost:8888/api

# View all available kernels
curl http://localhost:8888/api/kernels
```

**Expected healthy state:**
- Container status: "Up"
- Web interface accessible at http://localhost:8888
- All kernels listed in Launcher

## Documentation

- **Jupyter Lab**: https://jupyterlab.readthedocs.io/
- **.NET Interactive**: https://github.com/dotnet/interactive
- **IJava**: https://github.com/SpencerPark/IJava
- **gonb (Go kernel)**: https://github.com/janpfeifer/gonb
- **iruby**: https://github.com/SciRuby/iruby
- **tslab**: https://github.com/yunabe/tslab
- **PyTorch**: https://pytorch.org/docs/
- **TensorFlow**: https://www.tensorflow.org/api_docs/python

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.jupyter`

**Build from:** Custom Dockerfile (Ubuntu 22.04 base with multi-language kernel installation)

---

**Service Type:** Development Tool (Multi-Language IDE)
**Category:** dev-tools
**Deployment:** Requires custom image build before first run

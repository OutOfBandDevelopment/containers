# Go Development Container

Lightweight Go development environment with Go toolchain and modules support.

## Overview

Minimal Go container for Go development. Based on official Go Docker images with persistent workspace and module cache. Perfect for Go projects without multi-language overhead.

## Features

- **Official Go image**: Latest Go 1.23 by default
- **Go modules**: Full module support
- **Persistent workspace**: Projects preserved across restarts
- **Module cache**: Faster dependency downloads
- **Interactive shell**: Direct bash access
- **Lightweight**: Only Go and dependencies

## Quick Start

```bash
cd services/dev-tools/dev-go
./start.sh

# Inside container:
go version
go mod init example.com/hello
go run main.go
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| GO_VERSION | 1.23 | Go version |

## Usage Examples

### Hello World

```bash
cat > main.go << 'EOGO'
package main

import "fmt"

func main() {
    fmt.Println("Hello from Go!")
}
EOGO

go run main.go
```

### Module Project

```bash
go mod init example.com/myapp
go get github.com/gin-gonic/gin

cat > main.go << 'EOGO'
package main

import "github.com/gin-gonic/gin"

func main() {
    r := gin.Default()
    r.GET("/", func(c *gin.Context) {
        c.JSON(200, gin.H{"message": "Hello World"})
    })
    r.Run(":8080")
}
EOGO

go run main.go
```

### Build Binary

```bash
go build -o myapp
./myapp
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| go-workspace | /workspace | Project files | 1-10GB |
| go-modules | /go | Go modules and build cache | 500MB-5GB |

## Documentation

- **Go**: https://go.dev/doc/

---

**Service Type:** Development Tool (Go)
**Category:** dev-tools
**Deployment:** Uses official Go image

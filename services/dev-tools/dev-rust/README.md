# Rust Development Container

Lightweight Rust development environment with Cargo and rustc.

## Overview

Minimal Rust container for Rust development. Based on official Rust Docker images with persistent workspace and Cargo cache. Perfect for Rust projects without multi-language overhead.

## Features

- **Official Rust image**: Latest stable Rust by default
- **Cargo package manager**: Pre-installed
- **rustc compiler**: Ready to compile
- **Persistent workspace**: Projects preserved across restarts
- **Cargo cache**: Faster dependency builds
- **Interactive shell**: Direct bash access
- **Lightweight**: Only Rust toolchain

## Quick Start

```bash
cd services/dev-tools/dev-rust
./start.sh

# Inside container:
rustc --version
cargo --version
cargo new hello
cd hello && cargo run
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| RUST_VERSION | latest | Rust version |

## Usage Examples

### Hello World

```bash
cargo new hello_world
cd hello_world
cargo run
```

### Web Server with Actix

```bash
cargo new myapp
cd myapp

# Add dependency to Cargo.toml
cat >> Cargo.toml << 'EOTOML'
actix-web = "4"
EOTOML

# Create simple server
cat > src/main.rs << 'EORS'
use actix_web::{get, App, HttpServer, Responder};

#[get("/")]
async fn hello() -> impl Responder {
    "Hello World!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(hello))
        .bind("0.0.0.0:8080")?
        .run()
        .await
}
EORS

cargo run
```

### Build Release

```bash
cargo build --release
./target/release/myapp
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| rust-workspace | /workspace | Project files | 1-10GB |
| rust-cargo | /usr/local/cargo | Cargo registry and build cache | 1-10GB |

## Documentation

- **Rust**: https://doc.rust-lang.org/
- **Cargo**: https://doc.rust-lang.org/cargo/

---

**Service Type:** Development Tool (Rust)
**Category:** dev-tools
**Deployment:** Uses official Rust image

# Node.js Development Container

Lightweight Node.js development environment with npm and essential tools.

## Overview

Minimal Node.js container for JavaScript/TypeScript development. Based on official Node.js Docker images with persistent workspace and npm cache. Perfect for single-language Node.js projects without the overhead of multi-language environments.

## Features

- **Official Node.js image**: Latest LTS by default
- **npm package manager**: Pre-installed and ready
- **Persistent workspace**: Projects preserved across restarts
- **npm cache**: Faster package installations
- **Interactive shell**: Direct bash access
- **Lightweight**: Only Node.js and dependencies

## Quick Start

```bash
cd services/dev-tools/dev-node
./start.sh

# Inside container:
node --version
npm --version
npm init -y
npm install express
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| NODE_VERSION | lts | Node.js version (lts, 20, 18, etc.) |

## Usage Examples

### Create Express App

```bash
# Inside container
npm init -y
npm install express

cat > index.js << 'EOJS'
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello World!'));
app.listen(3000, () => console.log('Server on port 3000'));
EOJS

node index.js
```

### TypeScript Development

```bash
npm install -g typescript ts-node
npm install --save-dev @types/node

tsc --init
ts-node yourfile.ts
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| node-workspace | /workspace | Project files | 1-10GB |
| node-modules | /root/.npm | npm package cache | 500MB-5GB |

## Use in Compositions

```yaml
services:
  node-dev:
    extends:
      file: ../../services/dev-tools/dev-node/docker-compose.yml
      service: dev-node
    networks:
      - dev-network
```

## Documentation

- **Node.js**: https://nodejs.org/docs/
- **npm**: https://docs.npmjs.com/

---

**Service Type:** Development Tool (Node.js)
**Category:** dev-tools
**Deployment:** Uses official Node.js image

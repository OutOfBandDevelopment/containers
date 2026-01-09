# Apache Tika

Content analysis and extraction toolkit for detecting and extracting metadata and text from over a thousand different file types.

## Overview

Apache Tika is a content detection and analysis framework that provides a unified interface for extracting text and metadata from various document formats. It's commonly used for document processing, search indexing, and content analysis.

## Features

- Detects and extracts text from 1000+ file formats
- Metadata extraction
- Language detection
- MIME type detection
- OCR support (with Tesseract)
- REST API
- Batch processing

## Supported Formats

- **Documents**: PDF, Office (Word, Excel, PowerPoint), OpenOffice
- **Images**: JPEG, PNG, GIF, TIFF (with OCR)
- **Archives**: ZIP, TAR, GZIP
- **Email**: PST, MSG, MBOX
- **Audio/Video**: MP3, MP4, AVI metadata
- **And many more**

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Start service
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Start service
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| TIKA_VERSION | latest | Apache Tika image version |
| TIKA_PORT | 9998 | HTTP API port |

## Accessing the Service

After starting:

- **REST API**: http://localhost:9998
- **API Docs**: http://localhost:9998/

## API Examples

**Extract text from a file:**
```bash
curl -X PUT --data-binary @document.pdf \
  http://localhost:9998/tika \
  -H "Accept: text/plain"
```

**Get metadata:**
```bash
curl -X PUT --data-binary @document.pdf \
  http://localhost:9998/meta \
  -H "Accept: application/json"
```

**Detect MIME type:**
```bash
curl -X PUT --data-binary @document.pdf \
  http://localhost:9998/detect/stream \
  -H "Accept: text/plain"
```

**Extract text and metadata:**
```bash
curl -X PUT --data-binary @document.pdf \
  http://localhost:9998/rmeta/text \
  -H "Accept: application/json"
```

**Language detection:**
```bash
curl -X PUT -d "This is a sample English text" \
  http://localhost:9998/language/stream
```

## Python Example

```python
import requests

# Extract text
with open('document.pdf', 'rb') as f:
    response = requests.put(
        'http://localhost:9998/tika',
        data=f,
        headers={'Accept': 'text/plain'}
    )
    text = response.text
    print(text)

# Get metadata
with open('document.pdf', 'rb') as f:
    response = requests.put(
        'http://localhost:9998/meta',
        data=f,
        headers={'Accept': 'application/json'}
    )
    metadata = response.json()
    print(metadata)
```

## Node.js Example

```javascript
const fs = require('fs');
const axios = require('axios');

// Extract text
const fileBuffer = fs.readFileSync('document.pdf');

axios.put('http://localhost:9998/tika', fileBuffer, {
    headers: {
        'Accept': 'text/plain',
        'Content-Type': 'application/pdf'
    }
}).then(response => {
    console.log(response.data);
});
```

## Persistent Volumes

This service is stateless and does not require persistent volumes. All processing is done in-memory.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  apache-tika:
    extends:
      file: ../../services/utilities/apache-tika/docker-compose.yml
      service: apache-tika
```

## Health Check

```bash
curl http://localhost:9998/tika
```

## Documentation

- Official Website: https://tika.apache.org/
- REST API: https://cwiki.apache.org/confluence/display/TIKA/TikaServer
- Docker Hub: https://hub.docker.com/r/apache/tika
- GitHub: https://github.com/apache/tika-docker

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.apache-tika.yml`

---

**Service Type:** Utility (Document Processing)
**Category:** Content Analysis
**Deployment:** Standalone container (stateless)

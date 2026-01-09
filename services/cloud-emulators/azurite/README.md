# Azurite

Open-source Azure Storage API-compatible emulator for local development and testing with Blob, Queue, and Table storage.

## Overview

Azurite is Microsoft's official Azure Storage emulator that provides a free local environment for testing Azure Storage applications. It implements Azure Storage APIs for Blob, Queue, and Table services.

## Features

- Blob storage emulation
- Queue storage emulation
- Table storage emulation
- Azure Storage SDK compatible
- Cross-platform
- Persistent storage
- OAuth support
- CORS configuration
- Multiple account support

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
| AZURITE_VERSION | latest | Azurite image version |
| AZURITE_BLOB_PORT | 10000 | Blob service port |
| AZURITE_QUEUE_PORT | 10001 | Queue service port |
| AZURITE_TABLE_PORT | 10002 | Table service port |

## Accessing the Service

After starting:

- **Blob Service**: http://localhost:10000
- **Queue Service**: http://localhost:10001
- **Table Service**: http://localhost:10002

## Default Account

Azurite uses a well-known default account for development:

**Account Name:** `devstoreaccount1`

**Account Key:**
```
Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==
```

## Connection Strings

**Blob Service:**
```
DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://localhost:10000/devstoreaccount1;
```

**Queue Service:**
```
DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;QueueEndpoint=http://localhost:10001/devstoreaccount1;
```

**Table Service:**
```
DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;TableEndpoint=http://localhost:10002/devstoreaccount1;
```

## Python Example (azure-storage-blob)

```python
from azure.storage.blob import BlobServiceClient

connection_string = "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://localhost:10000/devstoreaccount1;"

# Create client
blob_service_client = BlobServiceClient.from_connection_string(connection_string)

# Create container
container_client = blob_service_client.create_container("mycontainer")

# Upload blob
blob_client = blob_service_client.get_blob_client(
    container="mycontainer",
    blob="myblob.txt"
)
blob_client.upload_blob("Hello, Azurite!")

# Download blob
download_stream = blob_client.download_blob()
print(download_stream.readall())
```

## .NET Example (Azure.Storage.Blobs)

```csharp
using Azure.Storage.Blobs;

var connectionString = "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://localhost:10000/devstoreaccount1;";

// Create client
var blobServiceClient = new BlobServiceClient(connectionString);

// Create container
var containerClient = blobServiceClient.GetBlobContainerClient("mycontainer");
await containerClient.CreateIfNotExistsAsync();

// Upload blob
var blobClient = containerClient.GetBlobClient("myblob.txt");
await blobClient.UploadAsync(
    new BinaryData("Hello, Azurite!"),
    overwrite: true
);

// Download blob
var downloadInfo = await blobClient.DownloadContentAsync();
Console.WriteLine(downloadInfo.Value.Content.ToString());
```

## Node.js Example (@azure/storage-blob)

```javascript
const { BlobServiceClient } = require('@azure/storage-blob');

const connectionString = "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://localhost:10000/devstoreaccount1;";

async function main() {
    // Create client
    const blobServiceClient = BlobServiceClient.fromConnectionString(connectionString);

    // Create container
    const containerName = "mycontainer";
    const containerClient = blobServiceClient.getContainerClient(containerName);
    await containerClient.createIfNotExists();

    // Upload blob
    const blobName = "myblob.txt";
    const blockBlobClient = containerClient.getBlockBlobClient(blobName);
    await blockBlobClient.upload("Hello, Azurite!", 15);

    // Download blob
    const downloadResponse = await blockBlobClient.download(0);
    const downloaded = await streamToText(downloadResponse.readableStreamBody);
    console.log(downloaded);
}

main();
```

## Using Azure Storage Explorer

Azure Storage Explorer can connect to Azurite:

1. Open Azure Storage Explorer
2. Click "Add an account" (plug icon)
3. Select "Attach to a local emulator"
4. Use default ports (10000, 10001, 10002)
5. Click "Connect"

## Testing with curl

**Create container:**
```bash
curl -X PUT "http://localhost:10000/devstoreaccount1/mycontainer?restype=container" \
  -H "x-ms-date: $(date -u '+%a, %d %b %Y %H:%M:%S GMT')" \
  -H "x-ms-version: 2019-12-12"
```

**Upload blob:**
```bash
curl -X PUT "http://localhost:10000/devstoreaccount1/mycontainer/myblob.txt" \
  -H "x-ms-blob-type: BlockBlob" \
  -H "x-ms-date: $(date -u '+%a, %d %b %Y %H:%M:%S GMT')" \
  -H "x-ms-version: 2019-12-12" \
  -d "Hello, Azurite!"
```

## Persistent Volumes

This service uses one persistent volume:

- **azurite-data**: Blob, queue, and table data (`/data`)

Data persists across container restarts.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  azurite:
    extends:
      file: ../../services/cloud-emulators/azurite/docker-compose.yml
      service: azurite
```

## Health Check

```bash
curl http://localhost:10000/devstoreaccount1?comp=list
```

## Documentation

- Official Docs: https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite
- GitHub: https://github.com/Azure/Azurite
- Azure Storage APIs: https://learn.microsoft.com/en-us/rest/api/storageservices/

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.azurite.yml`

---

**Service Type:** Cloud Emulator (Azure Storage)
**Category:** Development Tools
**Deployment:** Standalone container with persistence

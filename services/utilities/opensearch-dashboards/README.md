# OpenSearch Dashboards

Visualization and user interface for OpenSearch, providing data exploration, visualization, and dashboarding capabilities.

## Overview

OpenSearch Dashboards is the default visualization tool for OpenSearch. It provides an intuitive interface for searching, visualizing, and analyzing data stored in OpenSearch indices.

## Features

- Interactive data visualization
- Real-time search and filtering
- Dashboard creation and management
- Index pattern management
- Kibana-compatible visualizations
- Dev Tools console
- Query DSL builder
- Time series analysis

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration
nano .env

# Start service (requires OpenSearch to be running)
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Edit configuration
notepad .env

# Start service (requires OpenSearch to be running)
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| OPENSEARCH_DASHBOARDS_VERSION | latest | OpenSearch Dashboards version |
| OPENSEARCH_DASHBOARDS_PORT | 5601 | Web UI port |
| OPENSEARCH_HOSTS | ["http://opensearch:9200"] | OpenSearch connection URL |
| DISABLE_SECURITY | false | Disable security (dev only) |

## Accessing the Service

After starting:

- **Web UI**: http://localhost:5601

**Default credentials** (if using default OpenSearch with security):
- Username: admin
- Password: (your OpenSearch admin password)

## Prerequisites

This service requires a running OpenSearch instance.

**Using composition:**
```yaml
services:
  opensearch:
    extends:
      file: ../../services/databases/opensearch/docker-compose.yml
      service: opensearch
    networks:
      - opensearch-network

  opensearch-dashboards:
    extends:
      file: ../../services/utilities/opensearch-dashboards/docker-compose.yml
      service: opensearch-dashboards
    networks:
      - opensearch-network

networks:
  opensearch-network:
```

## Common Tasks

### Create Index Pattern

1. Open http://localhost:5601
2. Navigate to Management → Stack Management → Index Patterns
3. Click "Create index pattern"
4. Enter pattern (e.g., `logs-*`)
5. Select timestamp field
6. Click "Create index pattern"

### Create Visualization

1. Navigate to Visualize
2. Click "Create visualization"
3. Select visualization type
4. Choose index pattern
5. Configure metrics and buckets
6. Save visualization

### Create Dashboard

1. Navigate to Dashboard
2. Click "Create dashboard"
3. Click "Add" to add visualizations
4. Arrange and resize panels
5. Save dashboard

### Dev Tools Console

1. Navigate to Dev Tools
2. Write queries in the console:
   ```json
   GET _cat/indices?v

   GET my-index/_search
   {
     "query": {
       "match_all": {}
     }
   }
   ```
3. Click the play button to execute

## Persistent Volumes

This service is UI-only and does not require persistent volumes. Configuration is stored in the connected OpenSearch instance.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  opensearch-dashboards:
    extends:
      file: ../../services/utilities/opensearch-dashboards/docker-compose.yml
      service: opensearch-dashboards
```

## Health Check

```bash
curl -I http://localhost:5601/api/status
```

## Troubleshooting

**Cannot connect to OpenSearch:**
- Ensure OpenSearch is running
- Check OPENSEARCH_HOSTS environment variable
- Verify network connectivity between containers

**Login fails:**
- Verify OpenSearch credentials
- Check if security is properly configured in both services

## Documentation

- Official Docs: https://opensearch.org/docs/latest/dashboards/
- OpenSearch Docs: https://opensearch.org/docs/latest/
- GitHub: https://github.com/opensearch-project/OpenSearch-Dashboards

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.opensearch-dashboards.yml`

---

**Service Type:** Utility (Visualization UI)
**Category:** Search Analytics
**Deployment:** Standalone container (requires OpenSearch)

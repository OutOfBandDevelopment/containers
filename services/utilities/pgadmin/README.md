# pgAdmin

Web-based administration tool for PostgreSQL databases, providing a comprehensive interface for managing database servers, databases, and SQL operations.

## Overview

pgAdmin is the most popular and feature-rich Open Source administration and development platform for PostgreSQL. It's designed to meet the needs of database administrators and developers working with PostgreSQL.

## Features

- Visual query builder
- SQL editor with syntax highlighting
- Database schema management
- Backup and restore
- User management
- Server monitoring
- Query execution planner
- Data import/export
- Support for multiple PostgreSQL servers

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration (IMPORTANT: Change credentials)
nano .env

# Start service
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Edit configuration (IMPORTANT: Change credentials)
notepad .env

# Start service
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| PGADMIN_VERSION | latest | pgAdmin image version |
| PGADMIN_PORT | 8082 | Web UI port |
| PGADMIN_EMAIL | admin@example.com | Login email (CHANGE!) |
| PGADMIN_PASSWORD | YourStrong@Password | Login password (CHANGE!) |
| PGADMIN_COOKIE_PROTECTION | True | Enhanced cookie security |
| PGADMIN_LOGIN_BANNER | "Authorised users only!" | Login page banner |
| PGADMIN_LOG_LEVEL | 10 | Logging level (10=DEBUG) |

## Accessing the Service

After starting:

- **Web UI**: http://localhost:8082
- **Login**: Use email and password from .env file

## Adding a PostgreSQL Server

1. Open http://localhost:8082
2. Login with your credentials
3. Right-click "Servers" → "Register" → "Server"
4. **General tab**: Enter a name
5. **Connection tab**:
   - Host: `host.docker.internal` (for databases on host)
   - Port: 5432 (default PostgreSQL port)
   - Maintenance database: postgres
   - Username: postgres
   - Password: [your postgres password]
   - Save password: Yes (optional)

## Connecting to Containerized PostgreSQL

If connecting to a PostgreSQL container in the same Docker network:

```yaml
services:
  pgadmin:
    extends:
      file: ../../services/utilities/pgadmin/docker-compose.yml
      service: pgadmin
    networks:
      - database-network

  postgres:
    image: postgres:15
    networks:
      - database-network

networks:
  database-network:
```

Connection settings:
- Host: `postgres` (container name)
- Port: 5432

## Persistent Volumes

This service uses one persistent volume:

- **pgadmin-data**: Configuration and saved connections (`/var/lib/pgadmin`)

Data persists across container restarts.

## Common Tasks

### Backup Database

1. Right-click database → "Backup"
2. Choose format (Custom, Tar, Plain, Directory)
3. Select options
4. Click "Backup"

### Restore Database

1. Right-click database → "Restore"
2. Select backup file
3. Configure options
4. Click "Restore"

### Execute SQL

1. Select database
2. Tools → Query Tool
3. Write SQL query
4. Click Execute (F5)

### View Query Plan

1. Write query in Query Tool
2. Click "Explain" or "Explain Analyze"
3. View execution plan

## Security Notes

**Production deployment:**
1. Change default email and password
2. Use strong passwords
3. Enable HTTPS (requires reverse proxy)
4. Restrict network access
5. Regular updates
6. Consider using PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  pgadmin:
    extends:
      file: ../../services/utilities/pgadmin/docker-compose.yml
      service: pgadmin
```

## Health Check

```bash
curl -I http://localhost:8082
```

Should return HTTP 200.

## Documentation

- Official Website: https://www.pgadmin.org/
- Documentation: https://www.pgadmin.org/docs/
- Docker Hub: https://hub.docker.com/r/dpage/pgadmin4
- GitHub: https://github.com/pgadmin-org/pgadmin4

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.pgadmin.yml`

---

**Service Type:** Utility (Database Management UI)
**Category:** PostgreSQL Administration
**Deployment:** Standalone container with persistence

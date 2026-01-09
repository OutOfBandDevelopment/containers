# ParadeDB

PostgreSQL with Elasticsearch-quality full-text search built-in. Simple, powerful search for Postgres.

## Overview

ParadeDB is a PostgreSQL distribution that brings Elasticsearch-quality full-text search directly into Postgres. It combines the reliability and ACID guarantees of PostgreSQL with advanced search capabilities including BM25 scoring, fuzzy search, and more.

## Features

- Full-text search with BM25 ranking
- Fuzzy search and typo tolerance
- Faceted search
- Highlighting and snippets
- JSON search
- Hybrid search (combining BM25 with vector search)
- Built on PostgreSQL (all standard Postgres features available)
- pg_search and pg_analytics extensions

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration (IMPORTANT: Change passwords)
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

# Edit configuration (IMPORTANT: Change passwords)
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
| PARADEDB_VERSION | latest | ParadeDB image version |
| PARADEDB_PORT | 5432 | PostgreSQL port |
| POSTGRESQL_USERNAME | admin | Application user |
| POSTGRESQL_PASSWORD | YourStrong@Password | Application password (CHANGE!) |
| POSTGRESQL_POSTGRES_PASSWORD | YourStrong@Password | Postgres superuser password (CHANGE!) |
| POSTGRESQL_DATABASE | paradedb | Default database name |

## Accessing the Service

**Using psql (inside container):**
```bash
docker exec -it paradedb psql -U admin -d paradedb
```

**Using psql (from host):**
```bash
psql -h localhost -p 5432 -U admin -d paradedb
```

**Using pgAdmin, DBeaver, or other PostgreSQL clients:**
- Host: localhost
- Port: 5432
- Database: paradedb
- Username: admin
- Password: (from your .env file)

## Search Examples

**Enable pg_search extension:**
```sql
CREATE EXTENSION IF NOT EXISTS pg_search;
```

**Create a table and add BM25 search:**
```sql
-- Create table
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    title TEXT,
    content TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Insert sample data
INSERT INTO documents (title, content) VALUES
    ('Introduction to ParadeDB', 'ParadeDB brings Elasticsearch-quality search to PostgreSQL'),
    ('Full-Text Search', 'Learn about BM25 ranking and advanced search features'),
    ('Getting Started', 'Quick start guide for ParadeDB installation');

-- Create BM25 index
CALL paradedb.create_bm25(
    index_name => 'documents_idx',
    table_name => 'documents',
    key_field => 'id',
    text_fields => '{title: {}, content: {}}'
);

-- Search with BM25
SELECT * FROM documents_idx.search(
    query => 'search features'
) LIMIT 10;
```

**Fuzzy search:**
```sql
SELECT * FROM documents_idx.search(
    query => 'elasticserch~',  -- typo tolerance
    lenient => true
);
```

**Faceted search:**
```sql
-- Add category field and search with facets
SELECT * FROM documents_idx.search(
    query => 'PostgreSQL',
    facets => '{"category": {}}'::jsonb
);
```

## Connection Strings

**Python (psycopg2):**
```python
import psycopg2

conn = psycopg2.connect(
    host="localhost",
    port=5432,
    database="paradedb",
    user="admin",
    password="YourStrong@Password"
)
```

**.NET (Npgsql):**
```csharp
var connectionString = "Host=localhost;Port=5432;Database=paradedb;Username=admin;Password=YourStrong@Password";
```

**Node.js (pg):**
```javascript
const { Pool } = require('pg');

const pool = new Pool({
    host: 'localhost',
    port: 5432,
    database: 'paradedb',
    user: 'admin',
    password: 'YourStrong@Password'
});
```

## Persistent Volumes

This service uses one persistent volume:

- **paradedb-data**: PostgreSQL data directory (`/bitnami/postgresql`)

Data persists across container restarts.

## Backup & Restore

**Backup database:**
```bash
docker exec paradedb pg_dump -U admin paradedb > backup.sql
```

**Restore database:**
```bash
cat backup.sql | docker exec -i paradedb psql -U admin paradedb
```

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  paradedb:
    extends:
      file: ../../services/databases/paradedb/docker-compose.yml
      service: paradedb
```

## Health Check

```bash
docker exec paradedb pg_isready -U admin
```

## Documentation

- Official Docs: https://docs.paradedb.com/
- GitHub: https://github.com/paradedb/paradedb
- Search Guide: https://docs.paradedb.com/search/overview
- PostgreSQL Docs: https://www.postgresql.org/docs/

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.paradedb.yml`

---

**Service Type:** Database (PostgreSQL + Full-Text Search)
**Category:** Search-Enhanced Database
**Deployment:** Standalone container

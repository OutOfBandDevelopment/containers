# Microsoft SQL Server

Enterprise-grade relational database management system from Microsoft, running in Docker container.

## Overview

SQL Server provides a comprehensive database platform for mission-critical applications with enterprise-level features including high availability, security, and advanced analytics.

## Features

- Full T-SQL support
- Enterprise-grade performance
- Advanced security features
- High availability options
- JSON support
- Full-text search
- Columnstore indexes
- In-memory OLTP

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration (IMPORTANT: Change SA password)
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

# Edit configuration (IMPORTANT: Change SA password)
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
| SQL_SERVER_VERSION | 2022-latest | SQL Server version (2019, 2022) |
| SQL_SERVER_PORT | 1433 | Database port |
| MSSQL_SA_PASSWORD | YourStrong@Passw0rd | SA password (CHANGE THIS!) |
| MSSQL_PID | Developer | Edition (Developer, Express, Standard) |
| MSSQL_COLLATION | SQL_Latin1_General_CP1_CI_AS | Default collation |

### Password Requirements

The SA password must meet SQL Server password policy:
- At least 8 characters
- Contains uppercase letters
- Contains lowercase letters
- Contains digits (0-9)
- Contains symbols (!@#$%^&*)

## Accessing the Service

After starting:

**Using sqlcmd (inside container):**
```bash
docker exec -it sql-server /opt/mssql-tools/bin/sqlcmd \
  -S localhost -U sa -P 'YourStrong@Passw0rd'
```

**Using Azure Data Studio or SQL Server Management Studio:**
- Server: localhost,1433
- Authentication: SQL Server Authentication
- Login: sa
- Password: (from your .env file)

## SQL Examples

**Create a database:**
```sql
CREATE DATABASE MyDatabase;
GO

USE MyDatabase;
GO
```

**Create a table:**
```sql
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE()
);
GO
```

**Insert data:**
```sql
INSERT INTO Users (Username, Email)
VALUES ('john_doe', 'john@example.com');
GO
```

**Query data:**
```sql
SELECT * FROM Users;
GO
```

## Connection Strings

**.NET:**
```
Server=localhost,1433;Database=MyDatabase;User Id=sa;Password=YourStrong@Passw0rd;TrustServerCertificate=True;
```

**Python (pyodbc):**
```python
import pyodbc

conn = pyodbc.connect(
    'DRIVER={ODBC Driver 18 for SQL Server};'
    'SERVER=localhost,1433;'
    'DATABASE=MyDatabase;'
    'UID=sa;'
    'PWD=YourStrong@Passw0rd;'
    'TrustServerCertificate=yes;'
)
```

**Node.js (mssql):**
```javascript
const sql = require('mssql');

const config = {
    server: 'localhost',
    port: 1433,
    user: 'sa',
    password: 'YourStrong@Passw0rd',
    database: 'MyDatabase',
    options: {
        encrypt: true,
        trustServerCertificate: true
    }
};
```

## Persistent Volumes

This service uses one persistent volume:

- **sqlserver-data**: All SQL Server data, logs, and system files (`/var/opt/mssql`)

Data persists across container restarts.

## Backup & Restore

**Backup a database:**
```sql
BACKUP DATABASE MyDatabase
TO DISK = '/var/opt/mssql/backup/MyDatabase.bak'
WITH FORMAT;
GO
```

**Restore a database:**
```sql
RESTORE DATABASE MyDatabase
FROM DISK = '/var/opt/mssql/backup/MyDatabase.bak'
WITH REPLACE;
GO
```

## System Requirements

- Minimum 2GB RAM (4GB+ recommended)
- 2+ CPU cores recommended

## Editions

**Developer** (Default):
- Full Enterprise features
- Free for development/testing
- NOT licensed for production

**Express** (Free):
- Limited to 10GB per database
- 1GB RAM, 4 cores
- Free for production use

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  sql-server:
    extends:
      file: ../../services/databases/sql-server/docker-compose.yml
      service: sql-server
```

## Health Check

```bash
docker exec sql-server /opt/mssql-tools/bin/sqlcmd \
  -S localhost -U sa -P 'YourStrong@Passw0rd' \
  -Q "SELECT @@VERSION"
```

## Documentation

- Official Docs: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-overview
- Docker Hub: https://hub.docker.com/_/microsoft-mssql-server
- T-SQL Reference: https://learn.microsoft.com/en-us/sql/t-sql/language-reference

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.sql-server.yml`

---

**Service Type:** Database (Relational Database)
**Category:** Enterprise Database
**Deployment:** Standalone container

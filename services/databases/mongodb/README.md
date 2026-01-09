# MongoDB

Document-oriented NoSQL database designed for ease of development and scaling.

## Overview

MongoDB is a popular NoSQL database that stores data in flexible, JSON-like documents. It's designed for high performance, high availability, and automatic scaling.

## Features

- Document-oriented storage (JSON/BSON)
- Rich query language
- Aggregation framework
- Indexing (including text and geospatial)
- Replication and high availability
- Horizontal scaling (sharding)
- GridFS for large files
- Change streams

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
| MONGODB_VERSION | latest | MongoDB version (7, 6, 5) |
| MONGODB_PORT | 27017 | MongoDB port |
| MONGO_ROOT_USERNAME | admin | Root username (CHANGE!) |
| MONGO_ROOT_PASSWORD | YourStrong@Password | Root password (CHANGE!) |
| MONGO_INITDB_DATABASE | admin | Initial database |

## Accessing the Service

**Using mongosh (MongoDB Shell) inside container:**
```bash
docker exec -it mongodb mongosh -u admin -p YourStrong@Password
```

**Using mongosh from host:**
```bash
mongosh "mongodb://admin:YourStrong@Password@localhost:27017"
```

**Using MongoDB Compass:**
- Connection String: `mongodb://admin:YourStrong@Password@localhost:27017`

## MongoDB Shell Examples

**Show databases:**
```javascript
show dbs
```

**Create/switch to database:**
```javascript
use myapp
```

**Create collection and insert document:**
```javascript
db.users.insertOne({
    username: "john_doe",
    email: "john@example.com",
    age: 30,
    tags: ["developer", "mongodb"]
})
```

**Find documents:**
```javascript
// Find all
db.users.find()

// Find with filter
db.users.find({ age: { $gte: 25 } })

// Find one
db.users.findOne({ username: "john_doe" })
```

**Update document:**
```javascript
db.users.updateOne(
    { username: "john_doe" },
    { $set: { age: 31 } }
)
```

**Delete document:**
```javascript
db.users.deleteOne({ username: "john_doe" })
```

**Create index:**
```javascript
db.users.createIndex({ email: 1 }, { unique: true })
```

**Aggregation:**
```javascript
db.users.aggregate([
    { $match: { age: { $gte: 25 } } },
    { $group: { _id: "$age", count: { $sum: 1 } } },
    { $sort: { count: -1 } }
])
```

## Connection Strings

**Standard format:**
```
mongodb://admin:YourStrong@Password@localhost:27017/myapp?authSource=admin
```

**Python (pymongo):**
```python
from pymongo import MongoClient

client = MongoClient("mongodb://admin:YourStrong@Password@localhost:27017/")
db = client.myapp
```

**.NET (MongoDB.Driver):**
```csharp
var connectionString = "mongodb://admin:YourStrong@Password@localhost:27017/myapp?authSource=admin";
var client = new MongoClient(connectionString);
var database = client.GetDatabase("myapp");
```

**Node.js (mongodb):**
```javascript
const { MongoClient } = require('mongodb');

const uri = "mongodb://admin:YourStrong@Password@localhost:27017/myapp?authSource=admin";
const client = new MongoClient(uri);
```

**Java (MongoDB Java Driver):**
```java
String uri = "mongodb://admin:YourStrong@Password@localhost:27017/myapp?authSource=admin";
MongoClient mongoClient = MongoClients.create(uri);
MongoDatabase database = mongoClient.getDatabase("myapp");
```

## Persistent Volumes

This service uses two persistent volumes:

- **mongodb-data**: Database files (`/data/db`)
- **mongodb-config**: Configuration data (`/data/configdb`)

Data persists across container restarts.

## Backup & Restore

**Backup database:**
```bash
docker exec mongodb mongodump \
    -u admin -p YourStrong@Password \
    --authenticationDatabase admin \
    --db myapp \
    --out /tmp/backup

docker cp mongodb:/tmp/backup ./backup
```

**Restore database:**
```bash
docker cp ./backup mongodb:/tmp/backup

docker exec mongodb mongorestore \
    -u admin -p YourStrong@Password \
    --authenticationDatabase admin \
    --db myapp \
    /tmp/backup/myapp
```

## Create Application User

```javascript
use myapp

db.createUser({
    user: "appuser",
    pwd: "AppPassword123",
    roles: [
        { role: "readWrite", db: "myapp" }
    ]
})
```

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  mongodb:
    extends:
      file: ../../services/databases/mongodb/docker-compose.yml
      service: mongodb
```

## Health Check

```bash
docker exec mongodb mongosh \
    -u admin -p YourStrong@Password \
    --eval "db.adminCommand('ping')"
```

## Security Notes

**Production deployment:**
1. Always change default credentials
2. Use strong passwords
3. Enable authentication (enabled by default in this config)
4. Consider enabling TLS/SSL
5. Restrict network access
6. Regular backups

## Important Warnings

**Windows/macOS with bind mounts:**
MongoDB uses memory-mapped files which are not compatible with Windows/macOS filesystem sharing. Always use Docker volumes (not bind mounts) for the data directory.

## Documentation

- Official Docs: https://docs.mongodb.com/
- MongoDB Manual: https://docs.mongodb.com/manual/
- MongoDB University: https://university.mongodb.com/
- GitHub: https://github.com/mongodb/mongo

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.mongodb.yml`

---

**Service Type:** Database (NoSQL Document Database)
**Category:** Document Database
**Deployment:** Standalone container

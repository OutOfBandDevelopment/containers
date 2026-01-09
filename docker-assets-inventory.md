# Docker Assets Inventory

**Scan Date:** 2026-01-09 11:43:03
**Scan Root:** /current/src

This inventory identifies all Docker assets across repositories for migration into the containers collection.

---

## Summary

| Asset Type | Count |
|:-----------|------:|
| Dockerfiles | 9 |
| Docker Compose Files | 49 |
| .dockerignore Files | 11 |

---

## Dockerfiles Found

### [Company]/Notes/Retired Projects/[Services]/SubmissionClearing/code/src/ERisk.SubmissionClearing/ERisk.SubmissionClearing.API

| Field | Value |
|:------|:------|
| **Location** | `/current/src/[Company]/Notes/Retired Projects/[Services]/SubmissionClearing/code/src/ERisk.SubmissionClearing/ERisk.SubmissionClearing.API/Dockerfile` |
| **Privacy** | PRIVATE |
| **Base Image** | `mcr.microsoft.com/dotnet/aspnet:6.0` |
| **Size** | 28 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---

### code/learn/CQRS-Examples/src/ExampleApp/ExampleApp.WebApi

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/learn/CQRS-Examples/src/ExampleApp/ExampleApp.WebApi/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `mcr.microsoft.com/dotnet/aspnet:7.0` |
| **Size** | 21 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---

### code/learn/YearOfCode2024/src/hybridsearch/HybridSearchCSharp/OobDev.Search.WebApi

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/learn/YearOfCode2024/src/hybridsearch/HybridSearchCSharp/OobDev.Search.WebApi/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `mcr.microsoft.com/dotnet/aspnet:8.0` |
| **Size** | 38 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---

### code/learn/YearOfLanguages2023/src/tensorflow

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/learn/YearOfLanguages2023/src/tensorflow/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `tensorflow/tensorflow:latest-gpu
` |
| **Size** | 10 lines |

---

### code/private/AnotherOneBytesTheDust/SimilaritySearchExample/src/SimilaritySearchExample.Web

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/SimilaritySearchExample/src/SimilaritySearchExample.Web/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `mcr.microsoft.com/dotnet/aspnet:8.0` |
| **Size** | 24 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---

### code/private/ERiskTestApp/src/src/ERisk.SubmissionClearing/ERisk.SubmissionClearing.API

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/ERiskTestApp/src/src/ERisk.SubmissionClearing/ERisk.SubmissionClearing.API/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `mcr.microsoft.com/dotnet/aspnet:6.0` |
| **Size** | 28 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---

### code/private/MigratedFromTfs/src/ToyBox/OldStuff/Lightwell.ReferenceFramework/Lightwell.ReferenceFramework.Web.Api

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/MigratedFromTfs/src/ToyBox/OldStuff/Lightwell.ReferenceFramework/Lightwell.ReferenceFramework.Web.Api/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `microsoft/dotnet:2.1-aspnetcore-runtime` |
| **Size** | 19 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---

### code/private/MigratedFromTfs/src/ToyBox/OldStuff/Lightwell.ReferenceFramework/Lightwell.ReferenceFramework.Web

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/MigratedFromTfs/src/ToyBox/OldStuff/Lightwell.ReferenceFramework/Lightwell.ReferenceFramework.Web/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `microsoft/dotnet:2.1-aspnetcore-runtime` |
| **Size** | 19 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---

### code/public/SimilaritySearchExample/src/SimilaritySearchExample.Web

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/SimilaritySearchExample/src/SimilaritySearchExample.Web/Dockerfile` |
| **Privacy** | PUBLIC |
| **Base Image** | `mcr.microsoft.com/dotnet/aspnet:8.0` |
| **Size** | 24 lines |

**Build Type:** Multi-stage build

**Build Stages:**
```
base
build
publish
final
```

---


## Docker Compose Files Found

### Cadwell/projects/Cadwell.Poc/docker-compose.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/Cadwell/projects/Cadwell.Poc/docker-compose.yml` |
| **Privacy** | PRIVATE |
| **Services** | ~31 services |
| **Size** | 369 lines |

**Services:**
```
central-service
mongodb-primary
mongodb-secondary
redis
nginx
integration-service
prometheus
grafana
mongodb_primary_data
mongodb_secondary_data
mongodb_config
redis_data
prometheus_data
grafana_data
integration_data
hl7_messages
dicom_storage
frontend
backend
monitoring
mongodb_root_password
redis_password
central_service_cert
ssl_certificate
ssl_private_key
grafana_admin_password
integration_service_cert
hl7_encryption_key
fhir_client_cert
nginx_config
prometheus_config
```

---

### [Company]/Notes/Retired Projects/[Services]/SubmissionClearing/code/src/docker-compose-cpu.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/[Company]/Notes/Retired Projects/[Services]/SubmissionClearing/code/src/docker-compose-cpu.yml` |
| **Privacy** | PRIVATE |
| **Services** | ~3 services |
| **Size** | 16 lines |

**Services:**
```
sql-server
frontend
backend
```

---

### [Company]/Notes/Retired Projects/[Services]/SubmissionClearing/code/src/docker-compose.sql-server.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/[Company]/Notes/Retired Projects/[Services]/SubmissionClearing/code/src/docker-compose.sql-server.yml` |
| **Privacy** | PRIVATE |
| **Services** | ~0 services |
| **Size** | 13 lines |

---

### code/learn/YearOfCode2024/src/hybridsearch/HybridSearchCSharp/docker-compose.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/learn/YearOfCode2024/src/hybridsearch/HybridSearchCSharp/docker-compose.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~6 services |
| **Size** | 74 lines |

**Services:**
```
summary-generation:
sentence-embedding:
fulltext-search:
blob-storage:
vector-search:
web-api:
```

---

### code/learn/YearOfCode2024/src/sidecar-example/docker-compose.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/learn/YearOfCode2024/src/sidecar-example/docker-compose.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~3 services |
| **Size** | 29 lines |

**Services:**
```
sidecar:
frontend:
backend:
```

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose-cpu.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose-cpu.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~19 services |
| **Size** | 163 lines |

**Services:**
```
azurite
keycloak
apache-tika
mongodb
rabbitmq
smtp4dev
sql-server
sbert
ollama
open-webui
qdrant
paradedb
pgadmin
localstack
opensearch
opensearch-dashboards
kafka
frontend
backend
```

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose-cuda.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose-cuda.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~19 services |
| **Size** | 163 lines |

**Services:**
```
azurite
keycloak
apache-tika
mongodb
rabbitmq
smtp4dev
sql-server
sbert
ollama
open-webui
qdrant
paradedb
pgadmin
localstack
opensearch
opensearch-dashboards
kafka
frontend
backend
```

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.apache-tika.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.apache-tika.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 5 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.azurite.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.azurite.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 18 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.kafka.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.kafka.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~1 services |
| **Size** | 21 lines |

**Services:**
```
kafka
```

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.keycloak.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.keycloak.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 14 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.localstack.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.localstack.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 6 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.mongodb.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.mongodb.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 7 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.ollama.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.ollama.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 8 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.open-webui.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.open-webui.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 10 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.opensearch-dashboards.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.opensearch-dashboards.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~1 services |
| **Size** | 8 lines |

**Services:**
```
opensearch-dashboards
```

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.opensearch.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.opensearch.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~2 services |
| **Size** | 12 lines |

**Services:**
```
opensearch
volumes
```

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.paradedb.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.paradedb.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 13 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.pgadmin.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.pgadmin.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 14 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.qdrant.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.qdrant.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 9 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.rabbitmq.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.rabbitmq.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 8 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.sbert.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.sbert.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~1 services |
| **Size** | 9 lines |

**Services:**
```
sbert
```

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.smtp4dev.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.smtp4dev.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 10 lines |

---

### code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.sql-server.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/ContainerStore/docker/docker-compose.sql-server.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 11 lines |

---

### code/private/AnotherOneBytesTheDust/SimilaritySearchExample/src/docker-compose.webapi.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/AnotherOneBytesTheDust/SimilaritySearchExample/src/docker-compose.webapi.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 34 lines |

---

### code/private/ERiskTestApp/src/src/docker-compose-cpu.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/ERiskTestApp/src/src/docker-compose-cpu.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~3 services |
| **Size** | 16 lines |

**Services:**
```
sql-server
frontend
backend
```

---

### code/private/ERiskTestApp/src/src/docker-compose.sql-server.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/private/ERiskTestApp/src/src/docker-compose.sql-server.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 13 lines |

---

### code/public/RunScripts/MorePower/docker-compose.devbox.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/RunScripts/MorePower/docker-compose.devbox.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~3 services |
| **Size** | 23 lines |

**Services:**
```
devbox
root
npm-global-tools
```

---

### code/public/RunScripts/MorePower/docker-compose.plantuml.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/RunScripts/MorePower/docker-compose.plantuml.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~1 services |
| **Size** | 8 lines |

**Services:**
```
plantuml
```

---

### code/public/SimilaritySearchExample/src/docker-compose.webapi.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/SimilaritySearchExample/src/docker-compose.webapi.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 34 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose-cpu.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose-cpu.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~19 services |
| **Size** | 163 lines |

**Services:**
```
azurite
keycloak
apache-tika
mongodb
rabbitmq
smtp4dev
sql-server
sbert
ollama
open-webui
qdrant
paradedb
pgadmin
localstack
opensearch
opensearch-dashboards
kafka
frontend
backend
```

---

### code/public/[Company]-ContainerStore/docker/docker-compose-cuda.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose-cuda.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~19 services |
| **Size** | 163 lines |

**Services:**
```
azurite
keycloak
apache-tika
mongodb
rabbitmq
smtp4dev
sql-server
sbert
ollama
open-webui
qdrant
paradedb
pgadmin
localstack
opensearch
opensearch-dashboards
kafka
frontend
backend
```

---

### code/public/[Company]-ContainerStore/docker/docker-compose.apache-tika.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.apache-tika.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 5 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.azurite.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.azurite.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 18 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.kafka.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.kafka.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~1 services |
| **Size** | 21 lines |

**Services:**
```
kafka
```

---

### code/public/[Company]-ContainerStore/docker/docker-compose.keycloak.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.keycloak.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 14 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.localstack.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.localstack.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 6 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.mongodb.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.mongodb.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 7 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.ollama.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.ollama.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 8 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.open-webui.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.open-webui.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 10 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.opensearch-dashboards.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.opensearch-dashboards.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~1 services |
| **Size** | 8 lines |

**Services:**
```
opensearch-dashboards
```

---

### code/public/[Company]-ContainerStore/docker/docker-compose.opensearch.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.opensearch.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~2 services |
| **Size** | 12 lines |

**Services:**
```
opensearch
volumes
```

---

### code/public/[Company]-ContainerStore/docker/docker-compose.paradedb.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.paradedb.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 13 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.pgadmin.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.pgadmin.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 14 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.qdrant.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.qdrant.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 9 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.rabbitmq.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.rabbitmq.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 8 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.sbert.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.sbert.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~1 services |
| **Size** | 9 lines |

**Services:**
```
sbert
```

---

### code/public/[Company]-ContainerStore/docker/docker-compose.smtp4dev.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.smtp4dev.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 10 lines |

---

### code/public/[Company]-ContainerStore/docker/docker-compose.sql-server.yml

| Field | Value |
|:------|:------|
| **Location** | `/current/src/code/public/[Company]-ContainerStore/docker/docker-compose.sql-server.yml` |
| **Privacy** | PUBLIC |
| **Services** | ~0 services |
| **Size** | 11 lines |

---


## .dockerignore Files Found

- **[Company]/Notes/Retired Projects/[Services]/SubmissionClearing/code/src/ERisk.SubmissionClearing** (PRIVATE, 30 patterns)
- **code/learn/CQRS-Examples/src/ExampleApp** (PUBLIC, 25 patterns)
- **code/learn/YearOfCode2024/src/hybridsearch/HybridSearchCSharp** (PUBLIC, 30 patterns)
- **code/private/AnotherOneBytesTheDust/SimilaritySearchExample/src** (PUBLIC, 30 patterns)
- **code/private/AnotherOneBytesTheDust/TokenExchangeSample/src** (PUBLIC, 30 patterns)
- **code/private/AnotherOneBytesTheDust/Toys/MyApp** (PUBLIC, 20 patterns)
- **code/private/ERiskFramework/src/ERiskFramework** (PUBLIC, 30 patterns)
- **code/private/ERiskTestApp/src/src/ERisk.SubmissionClearing** (PUBLIC, 30 patterns)
- **code/private/MigratedFromTfs/src/ToyBox/OldStuff/Lightwell.ReferenceFramework** (PUBLIC, 9 patterns)
- **code/public/SimilaritySearchExample/src** (PUBLIC, 30 patterns)
- **code/public/[Company]-jhipster-sample-application** (PUBLIC, 20 patterns)

---


## Migration Recommendations

### High Priority (Public Assets - Easy Migration)

1. **RunScripts** - Docker wrapper patterns (if Dockerfiles exist)
2. **CQRS-Examples** - .NET microservices example
3. **Learning projects** - Educational examples

**Action:** Can be migrated immediately, no sanitization required.

### Medium Priority (Private Assets - Requires Sanitization)

1. **ContainerStore ([Company])** - AI/ML development stack
2. **Private repositories** - Various Docker assets

**Action:** Requires PII sanitization before migration. Use `/current/src/private/client-name-scanner.sh` to verify.

### Low Priority

1. Assets from deprecated or inactive projects
2. Highly client-specific configurations

**Action:** Review and decide case-by-case.

---

## Next Steps

1. **Review this inventory** - Identify migration priorities
2. **Public assets:** Migrate following migration-guide.md
3. **Private assets:** Sanitize using protocols in migration-guide.md, then migrate
4. **Update catalogs:** Keep docs/image-catalog.md and docs/compose-catalog.md synchronized

---

*Generated: 2026-01-08 19:41:51*
*Scan root: /current/src*
*Total Dockerfiles: 9*
*Total Compose files: 49*
*Total .dockerignore files: 11*

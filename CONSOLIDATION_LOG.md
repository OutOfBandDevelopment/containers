# Service Consolidation Log

This document tracks services that were consolidated from multiple sources into unified implementations.

## Consolidations

### 1. SBERT (Sentence Transformers) ✅

**Date:** 2026-01-09

**Sources Merged:**
1. ContainerStore `DockerFile.sbert` (CPU)
2. RunScripts `DockerFile.sbert` (CPU)
3. RunScripts `DockerFile.sbert-cuda` (GPU/CUDA)

**Result:** Single service at `services/ai-ml/sbert/`

**Implementation:**
- Single Dockerfile with `COMPUTE_PLATFORM` build arg (cpu/cuda)
- Docker Compose with profiles: `cpu` and `gpu`
- Both .sh and .bat management scripts:
  - `build-cpu.sh` / `build-cpu.bat`
  - `build-gpu.sh` / `build-gpu.bat`
  - `start-cpu.sh` / `start-cpu.bat`
  - `start-gpu.sh` / `start-gpu.bat`
  - `stop.sh` / `stop.bat`

**Benefits:**
- Single codebase, multiple deployment options
- Consistent API across CPU/GPU
- Shared model cache (HuggingFace models)
- Easier maintenance
- Clear separation via Docker Compose profiles

**Differences Handled:**
- PyTorch installation (CPU vs CUDA) via build args
- Python script path normalized to `sbert-server.py`
- Container naming (sbert-cpu / sbert-gpu)

**Usage:**
```bash
# CPU
cd services/ai-ml/sbert
./build-cpu.sh && ./start-cpu.sh

# GPU
./build-gpu.sh && ./start-gpu.sh

# Or with profiles
docker compose --profile cpu up -d
docker compose --profile gpu up -d
```

---

## Pending Consolidations

### eliassen-ContainerStore

**Status:** Already handled
**Note:** This is a duplicate of the private AnotherOneBytesTheDust/ContainerStore that we already migrated and sanitized. No additional action needed.

---

## Consolidation Guidelines

When multiple versions of the same service exist:

### 1. Identify Differences
- Compare Dockerfiles line by line
- Check for version differences
- Identify platform variants (CPU/GPU, architectures)
- Compare supporting files

### 2. Choose Consolidation Strategy

**Strategy A: Build Args**
- Use for compile-time differences (CPU vs GPU)
- Example: `ARG COMPUTE_PLATFORM=cpu`

**Strategy B: Docker Compose Profiles**
- Use for deployment variants
- Example: `profiles: ["cpu"]` vs `profiles: ["gpu"]`

**Strategy C: Environment Variables**
- Use for runtime configuration
- Example: Model selection, ports, paths

**Strategy D: Multiple Services (if too different)**
- Only if services are fundamentally different
- Example: Different programming languages, incompatible architectures

### 3. Create Unified Service

1. **Single Dockerfile** with build args for variants
2. **docker-compose.yml** with profiles
3. **Management scripts** (.sh and .bat) for common operations
4. **.env.template** with all configuration options
5. **README.md** documenting all variants

### 4. Document Consolidation

- Record in this log
- Note source locations
- Document differences handled
- Provide usage examples

### 5. Benefits to Document

- Reduced duplication
- Easier maintenance
- Consistent interfaces
- Clear variant selection

---

## Template: Consolidation Entry

```markdown
### Service Name ✅

**Date:** YYYY-MM-DD

**Sources Merged:**
1. Source 1 location
2. Source 2 location
3. Source N location

**Result:** Single service at `services/category/service-name/`

**Implementation:**
- Key consolidation decisions
- How variants are handled
- Script structure

**Benefits:**
- Why consolidation was valuable

**Differences Handled:**
- Major differences between sources
- How they were reconciled

**Usage:**
```bash
# Usage examples
```
```

---

*Created: 2026-01-09*
*Purpose: Track service consolidations and document consolidation patterns*

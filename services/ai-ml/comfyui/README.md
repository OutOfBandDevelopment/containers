# ComfyUI

Powerful node-based AI image generation interface with Stable Diffusion, supporting GPU acceleration.

## Overview

ComfyUI is a modular, node-based interface for Stable Diffusion that provides unparalleled flexibility and control over AI image generation workflows. Unlike simple prompt-based interfaces, ComfyUI allows you to build complex image generation pipelines by connecting nodes for models, samplers, conditioners, and post-processing operations.

This service uses the xingren23/comfyui Docker image which includes CUDA 12.1 support for NVIDIA GPUs, providing hardware-accelerated image generation. The image comes pre-configured with ComfyUI and essential dependencies, ready to load your Stable Diffusion models and start generating images.

Perfect for AI artists, researchers, and anyone who wants fine-grained control over their Stable Diffusion workflows without writing code.

## Features

- **Node-based workflow editor**: Visual programming interface for complex pipelines
- **Stable Diffusion support**: SD 1.x, SD 2.x, SDXL models
- **GPU acceleration**: CUDA 12.1 support for NVIDIA GPUs
- **Custom nodes**: Extensible with community plugins
- **Model management**: Load checkpoints, LoRAs, VAEs, and controlnets
- **Workflow saving**: Save and share generation workflows as JSON
- **Queue system**: Batch process multiple generations
- **Web interface**: Access via browser at http://localhost:8188
- **Persistent storage**: Models and outputs preserved across restarts

## Quick Start

### Prerequisites

**GPU Required:** ComfyUI requires an NVIDIA GPU with CUDA support for reasonable performance.

- NVIDIA GPU (6GB+ VRAM recommended)
- NVIDIA Docker runtime installed
- Stable Diffusion model files (checkpoints)

### Linux/macOS

```bash
cd services/ai-ml/comfyui

# Start ComfyUI
./start.sh

# Access the web interface at http://localhost:8188

# Stop ComfyUI
./stop.sh
```

### Windows

```batch
cd services\ai-ml\comfyui

REM Start ComfyUI
start.bat

REM Access the web interface at http://localhost:8188

REM Stop ComfyUI
stop.bat
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| COMFYUI_VERSION | comfyui-cu121-v1.0.7 | Image version with CUDA 12.1 |
| COMFYUI_PORT | 8188 | Web interface port |
| NVIDIA_VISIBLE_DEVICES | all | Which GPUs to use |

Edit `.env` after copying from `.env.template` to customize these values.

## Accessing the Service

**ComfyUI Web Interface**: http://localhost:8188

On first launch, you'll see the node editor with a default workflow. You'll need to add Stable Diffusion model files to generate images.

## Usage Examples

### Adding Models

Place your Stable Diffusion checkpoint files (.safetensors or .ckpt) in the models volume:

```bash
# Copy a model file into the container
docker cp model.safetensors comfyui:/root/ComfyUI/models/checkpoints/

# Or mount a host directory with models
# Edit docker-compose.yml to add:
# volumes:
#   - /path/to/your/models:/root/ComfyUI/models/checkpoints
```

### Basic Text-to-Image Workflow

1. Open http://localhost:8188
2. Load the default workflow or create a new one
3. Add nodes:
   - **Load Checkpoint**: Select your SD model
   - **CLIP Text Encode** (Positive): Enter your prompt
   - **CLIP Text Encode** (Negative): Enter negative prompt
   - **KSampler**: Configure generation settings (steps, CFG scale, seed)
   - **VAE Decode**: Decode latent to image
   - **Save Image**: Output the result
4. Connect the nodes
5. Click "Queue Prompt" to generate

### Installing Custom Nodes

```bash
# Access the container
docker exec -it comfyui bash

# Navigate to custom_nodes directory
cd /root/ComfyUI/custom_nodes

# Clone a custom node repository
git clone https://github.com/username/ComfyUI-CustomNode

# Install dependencies if needed
cd ComfyUI-CustomNode
pip install -r requirements.txt

# Restart ComfyUI
exit
docker compose restart
```

### Saving Workflows

1. Create your workflow in the node editor
2. Click "Save" button
3. Export as JSON to share with others
4. Load saved workflows with "Load" button

### Batch Processing

1. Create your workflow
2. Click "Queue Prompt" multiple times to add to queue
3. Or use different seeds for variations
4. ComfyUI processes queue sequentially

## Persistent Volumes

This service uses the following Docker volumes for persistent data:

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| comfyui-models | /root/ComfyUI/models | SD checkpoints, LoRAs, VAEs, ControlNets | 10-100GB |
| comfyui-input | /root/ComfyUI/input | Input images for img2img workflows | 1-5GB |
| comfyui-output | /root/ComfyUI/output | Generated images and outputs | 5-50GB |
| comfyui-custom-nodes | /root/ComfyUI/custom_nodes | Custom node extensions | 500MB-5GB |
| comfyui-workflows | /root/ComfyUI/user/default/workflows | Saved workflow JSON files | <100MB |

**Volume Descriptions:**
- **comfyui-models**: Stores all AI models (checkpoints can be 2-7GB each)
- **comfyui-input**: Source images for image-to-image and inpainting workflows
- **comfyui-output**: All generated images saved here
- **comfyui-custom-nodes**: Community extensions and plugins
- **comfyui-workflows**: Your saved workflow definitions

**Backup Recommendations:**
- Back up comfyui-workflows regularly (small, valuable)
- Back up comfyui-output to preserve generated images
- Models can be re-downloaded if lost

**Volume Management:**
```bash
# List volumes
docker volume ls | grep comfyui

# Inspect models volume
docker volume inspect comfyui-models

# Backup workflows and outputs
docker run --rm -v comfyui-workflows:/workflows -v comfyui-output:/output -v $(pwd):/backup ubuntu tar czf /backup/comfyui-backup.tar.gz /workflows /output

# Remove volumes (WARNING: deletes all models and outputs)
docker compose down -v
```

## Use in Compositions

To use this service in a composition with `extends`:

```yaml
services:
  comfyui:
    extends:
      file: ../../services/ai-ml/comfyui/docker-compose.yml
      service: comfyui
    networks:
      - ai-network
```

## Health Check

Check if ComfyUI is running and accessible:

```bash
# Check container status
docker compose ps

# Check logs
docker compose logs comfyui

# Test web interface
curl http://localhost:8188

# Check GPU access
docker exec comfyui nvidia-smi
```

**Expected healthy state:**
- Container status: "Up"
- Web interface responds at http://localhost:8188
- nvidia-smi shows GPU information

## Documentation

- **ComfyUI GitHub**: https://github.com/comfyanonymous/ComfyUI
- **ComfyUI Wiki**: https://github.com/comfyanonymous/ComfyUI/wiki
- **Custom Nodes Registry**: https://github.com/ltdrdata/ComfyUI-Manager
- **Workflows**: https://comfyworkflows.com/
- **xingren23/ComfyFlowApp**: https://github.com/xingren23/ComfyFlowApp
- **Docker References**:
  - https://github.com/YanWenKun/ComfyUI-Docker
  - https://github.com/ai-dock/comfyui
  - https://www.johnaldred.com/running-comfyui-in-docker-on-windows-or-linux/

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.comfyui`

**Base image:** xingren23/comfyui:comfyui-cu121-v1.0.7

---

**Service Type:** AI/ML Tool (Image Generation)
**Category:** ai-ml
**Deployment:** Uses third-party image, requires NVIDIA GPU

**Sources:**
- [ComfyUI Docker implementations](https://github.com/YanWenKun/ComfyUI-Docker)
- [Running ComfyUI in Docker](https://www.johnaldred.com/running-comfyui-in-docker-on-windows-or-linux/)
- [ComfyFlowApp](https://github.com/xingren23/ComfyFlowApp)

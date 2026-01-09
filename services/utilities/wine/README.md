# Wine (Windows Compatibility Layer)

Run Windows applications on Linux with Wine in a containerized environment with GUI support.

## Overview

Wine (Wine Is Not an Emulator) allows running Windows applications on Linux without requiring a Windows license. This service provides Wine stable in a Docker container with WSLg support for graphical applications on Windows WSL2 or X11 on Linux.

## Features

- **Wine Stable**: Latest stable version from WineHQ
- **32-bit and 64-bit support**: Wine32 for legacy applications
- **Winetricks**: Easy installation of Windows components
- **GUI support**: WSLg (Windows WSL2) or X11 (Linux)
- **MFC40**: Microsoft Foundation Classes pre-installed
- **Persistent Wine prefix**: Configuration preserved across restarts

## Quick Start

```bash
cd services/utilities/wine
./build.sh
./start.sh

# Inside the container:
wine notepad.exe
wine your-app.exe
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| WINE_VERSION | latest | Image version/tag |

## Usage Examples

### Run Windows Executable

```bash
# Copy .exe into container
docker cp myapp.exe wine:/workspace/

# Run with Wine
docker exec -it wine wine /workspace/myapp.exe
```

### Install Components with Winetricks

```bash
docker exec -it wine winetricks dotnet48
docker exec -it wine winetricks vcrun2019
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| wine-prefix | /root/.wine | Wine configuration and C: drive | 1-10GB |
| wine-workspace | /workspace | Working directory for Windows apps | 1-50GB |

## Documentation

- **Wine HQ**: https://www.winehq.org/
- **Winetricks**: https://wiki.winehq.org/Winetricks

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.wine`

---

**Service Type:** Utility (Windows Compatibility)
**Category:** utilities
**Deployment:** Requires WSLg/X11, custom build

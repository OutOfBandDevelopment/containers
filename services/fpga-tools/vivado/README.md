# AMD/Xilinx Vivado (FPGA Development) - Manual Installation Required

AMD/Xilinx Vivado Design Suite for FPGA development. This service provides the dependencies; Vivado software must be downloaded and installed manually.

## Overview

Vivado Design Suite is AMD/Xilinx's comprehensive FPGA design software for Zynq, Artix, Kintex, and Virtex devices. This Docker service provides all required dependencies but **does not include Vivado itself** due to licensing and size constraints (20-100GB).

**You must download Vivado from AMD/Xilinx and install it manually.**

## Prerequisites

- Windows WSL2 with WSLg OR Linux with X11
- AMD/Xilinx account (free registration)
- 100+ GB free disk space
- Fast internet connection (installer is very large)

## Manual Installation Steps

### 1. Download Vivado

Visit AMD/Xilinx download page:
**https://www.xilinx.com/support/download.html**

Download:
- **Vivado ML Edition** (recommended): `Xilinx_Unified_2023.2_1013_2256_Lin64.bin`
- Or older versions from the archive

### 2. Place Installer

Copy the downloaded `.bin` file to this directory:
```bash
cp ~/Downloads/Xilinx_Unified_*.bin ./
```

### 3. Update Dockerfile

Edit `Dockerfile` and uncomment the installation lines:
```dockerfile
COPY Xilinx_Unified_*.bin /tmp/vivado-installer.bin
RUN chmod +x /tmp/vivado-installer.bin && \
    /tmp/vivado-installer.bin --mode unattended --installdir /opt/Xilinx && \
    rm /tmp/vivado-installer.bin
```

### 4. Build Image

```bash
./build.sh
# This will take 1-2 hours
```

### 5. Install Cable Drivers

After building, install cable drivers for FPGA programming:

```bash
docker exec -it vivado bash
cd /opt/Xilinx/Vivado/2023.2/data/xicom/cable_drivers/lin64/install_script/install_drivers
./install_drivers
```

### 6. Start Vivado

```bash
./start.sh
# Inside container:
/opt/Xilinx/Vivado/2023.2/bin/vivado
```

## Alternative: Volume Mount Existing Installation

If you already have Vivado installed on your host:

1. Edit `docker-compose.yml`:
```yaml
volumes:
  - /path/to/your/Xilinx:/opt/Xilinx:ro
```

2. Start the container:
```bash
./start.sh
/opt/Xilinx/Vivado/2023.2/bin/vivado
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| VIVADO_VERSION | latest | Image version/tag |

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| vivado-projects | /workspace | FPGA project files | 1-100GB |
| vivado-installation | /opt/Xilinx | Vivado software | 20-100GB |

## Reducing Installation Size

Vivado is massive. To reduce size, use selective installation:
- Uncheck "SDK" if you don't need embedded software
- Select only the FPGA families you use
- Skip documentation packages

See: https://support.xilinx.com/s/question/0D52E00006hpMixSAE/reducing-size-of-vivado-installation

## USB Programming

For FPGA programming, add USB device access:

Edit `docker-compose.yml`:
```yaml
devices:
  - /dev/bus/usb:/dev/bus/usb
privileged: true
```

## Documentation

- **AMD/Xilinx Vivado**: https://www.xilinx.com/products/design-tools/vivado.html
- **Installation Guide**: https://docs.xilinx.com/r/en-US/ug973-vivado-release-notes-install-license
- **Ubuntu Setup**: https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/
- **Cable Drivers**: https://support.xilinx.com/s/article/63794

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.Vivado`

**Note:** Source Dockerfile was incomplete (dependencies only). This service requires manual Vivado installation.

---

**Service Type:** FPGA Development Tool
**Category:** fpga-tools
**Deployment:** Requires manual Vivado installation, WSLg/X11

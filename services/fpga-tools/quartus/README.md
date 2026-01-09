# Intel Quartus (FPGA Development) - Manual Installation Required

Intel Quartus Prime development environment for FPGA design. This service provides the dependencies; Quartus software must be downloaded and installed manually.

## Overview

Intel Quartus Prime is the comprehensive FPGA design software for Intel (formerly Altera) FPGAs. This Docker service provides all required dependencies (Java, libraries, X11 support) but **does not include Quartus itself** due to licensing and size constraints (10-50GB).

**You must download Quartus from Intel and install it manually.**

## Prerequisites

- Windows WSL2 with WSLg OR Linux with X11
- Intel account (free registration at intel.com)
- 50+ GB free disk space
- Fast internet connection (installer is large)

## Manual Installation Steps

### 1. Download Quartus

Visit Intel's download page:
**https://www.intel.com/content/www/us/en/software-kit/825278/intel-quartus-prime-lite-edition-design-software-version-23-1-1-for-linux.html**

Download one of:
- **Quartus Prime Lite** (free, recommended): `Quartus-lite-23.1.1.993-linux.run`
- **Quartus Prime Standard/Pro** (requires license)

### 2. Place Installer

Copy the downloaded `.run` file to this directory:
```bash
cp ~/Downloads/Quartus-lite-*.run ./
```

### 3. Update Dockerfile

Edit `Dockerfile` and uncomment the installation lines:
```dockerfile
COPY Quartus-lite-*.run /tmp/quartus-installer.run
RUN chmod +x /tmp/quartus-installer.run && \
    /tmp/quartus-installer.run --mode unattended --installdir /opt/intelFPGA && \
    rm /tmp/quartus-installer.run
```

### 4. Build Image

```bash
./build.sh
# This will take 30-60 minutes
```

### 5. Start Quartus

```bash
./start.sh
# Inside container:
/opt/intelFPGA/*/quartus/bin/quartus
```

## Alternative: Volume Mount Existing Installation

If you already have Quartus installed on your host:

1. Edit `docker-compose.yml`:
```yaml
volumes:
  - /path/to/your/intelFPGA:/opt/intelFPGA:ro
```

2. Start the container:
```bash
./start.sh
/opt/intelFPGA/23.1/quartus/bin/quartus
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| QUARTUS_VERSION | latest | Image version/tag |

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| quartus-projects | /workspace | FPGA project files | 1-50GB |
| quartus-installation | /opt/intelFPGA | Quartus software | 10-50GB |

## Cable Drivers (for FPGA Programming)

After installing Quartus, install USB Blaster drivers:

```bash
docker exec -it quartus bash
cd /opt/intelFPGA/*/quartus/drivers/usbblaster/
./install.sh
```

Then restart the container with USB device access:
```yaml
devices:
  - /dev/bus/usb:/dev/bus/usb
```

## Documentation

- **Intel Quartus**: https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/quartus-prime.html
- **Installation Guide**: https://www.intel.com/content/www/us/en/docs/programmable/683472/current/introduction.html
- **Reference**: https://github.com/johanneswarwick/install-quartusweb-ubuntu

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.Quartus`

**Note:** Source Dockerfile was incomplete (dependencies only). This service requires manual Quartus installation.

---

**Service Type:** FPGA Development Tool
**Category:** fpga-tools
**Deployment:** Requires manual Quartus installation, WSLg/X11

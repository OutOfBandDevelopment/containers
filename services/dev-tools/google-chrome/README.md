# Google Chrome (Containerized GUI)

Google Chrome browser running in Docker with WSLg support for graphical display and remote debugging capabilities.

## Overview

This service provides Google Chrome in a Docker container with GUI support through WSLg (Windows Subsystem for Linux Graphics) on Windows or X11 on Linux. Perfect for automated browser testing, web scraping, or running Chrome in isolated environments. Includes Chrome DevTools Protocol remote debugging on port 9223.

**Prerequisites:**
- **Windows**: WSL2 with WSLg (Windows 11 or Windows 10 with updates)
- **Linux**: X11 server running
- **macOS**: Not recommended (requires XQuartz setup)

## Features

- **Latest Chrome**: Stable channel, automatically updated
- **GUI display**: WSLg on Windows, X11 on Linux
- **Remote debugging**: Chrome DevTools Protocol on port 9223
- **Isolated environment**: Separate Chrome profile and data
- **No GPU**: Runs in software rendering mode (compatible with containers)
- **Persistent data**: User profile and cache preserved

## Quick Start

### Windows WSL2

```bash
cd services/dev-tools/google-chrome

# Build the image
./build.sh

# Start Chrome (GUI will appear)
./start.sh

# Chrome window opens automatically
# Remote debugging: http://localhost:9223
```

### Linux (with X11)

```bash
cd services/dev-tools/google-chrome

# Allow Docker to connect to X server
xhost +local:docker

# Build and start
./build.sh
./start.sh

# Clean up when done
xhost -local:docker
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| CHROME_VERSION | latest | Image version/tag |
| CHROME_DEBUG_PORT | 9223 | Remote debugging port |

## Usage Examples

### Browser Automation with Puppeteer

```javascript
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.connect({
    browserURL: 'http://localhost:9223'
  });

  const page = await browser.newPage();
  await page.goto('https://example.com');
  console.log(await page.title());

  await browser.close();
})();
```

### Remote Debugging

Open http://localhost:9223 in another browser to access Chrome DevTools remotely.

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| chrome-data | /tmp/google-chrome | User profile and cache | 500MB-2GB |

**Volume Management:**
```bash
# Backup profile
docker run --rm -v chrome-data:/data -v $(pwd):/backup ubuntu tar czf /backup/chrome-backup.tar.gz /data

# Remove volume
docker compose down -v
```

## Troubleshooting

**Chrome window doesn't appear:**
- Windows: Ensure WSLg is installed (`wsl --update`)
- Linux: Run `xhost +local:docker` before starting

**No sound:**
- WSLg should handle audio automatically
- Check PulseAudio connection in logs

## Documentation

- **Chrome DevTools Protocol**: https://chromedevtools.github.io/devtools-protocol/
- **WSLg**: https://github.com/microsoft/wslg
- **Puppeteer**: https://pptr.dev/

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source files:** `MorePower/DockerFile.google-chrome`, `MorePower/chrome-start.sh`

---

**Service Type:** Development Tool (Browser)
**Category:** dev-tools
**Deployment:** Requires WSLg/X11, custom image build

# Python Development Container

Lightweight Python development environment with pip and essential tools.

## Overview

Minimal Python container for Python development. Based on official Python Docker images with persistent workspace and pip cache. Perfect for Python projects without multi-language overhead.

## Features

- **Official Python image**: Latest Python 3.12 by default
- **pip package manager**: Pre-installed
- **Persistent workspace**: Projects preserved across restarts
- **pip cache**: Faster package installations
- **Interactive shell**: Direct bash access
- **Lightweight**: Only Python and dependencies

## Quick Start

```bash
cd services/dev-tools/dev-python
./start.sh

# Inside container:
python --version
pip install requests
python myscript.py
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| PYTHON_VERSION | 3.12 | Python version |

## Usage Examples

### Simple Script

```bash
cat > hello.py << 'EOPY'
print("Hello from Python!")
EOPY

python hello.py
```

### Flask Web App

```bash
pip install flask

cat > app.py << 'EOPY'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOPY

python app.py
```

### Data Science

```bash
pip install pandas numpy matplotlib
python
>>> import pandas as pd
>>> import numpy as np
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| python-workspace | /workspace | Project files | 1-10GB |
| python-pip | /root/.cache/pip | pip package cache | 500MB-5GB |

## Documentation

- **Python**: https://docs.python.org/3/

---

**Service Type:** Development Tool (Python)
**Category:** dev-tools
**Deployment:** Uses official Python image

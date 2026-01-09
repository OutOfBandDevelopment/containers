# TensorFlow Jupyter Lab

Official TensorFlow image with Jupyter Lab for machine learning development and experimentation.

## Overview

This service provides TensorFlow with Jupyter Lab in a containerized environment, perfect for machine learning development, model training, and data science workflows. Based on the official TensorFlow Docker images, it includes TensorFlow, Keras, Jupyter Lab, and common data science libraries like pandas, matplotlib, seaborn, and scikit-learn.

Ideal for ML engineers, data scientists, and researchers who want a ready-to-use TensorFlow environment without local installation complexity. Supports both CPU and GPU modes for flexible deployment.

## Features

- **TensorFlow + Keras**: Latest TensorFlow with high-level Keras API
- **Jupyter Lab**: Modern notebook interface with extensions
- **Data science libraries**: pandas, matplotlib, seaborn, scikit-learn pre-installed
- **CPU and GPU support**: Use latest tag for CPU, latest-gpu for NVIDIA GPU acceleration
- **Persistent workspace**: Notebooks and models preserved across restarts
- **No authentication by default**: Easy local development (configurable for production)
- **Isolated Keras home**: Separate volume for Keras models and weights

## Quick Start

### Linux/macOS

```bash
cd services/ai-ml/tensorflow-jupyterlab

# Build the image (first time)
./build.sh

# Start Jupyter Lab
./start.sh

# Access at http://localhost:8889

# Stop service
./stop.sh
```

### Windows

```batch
cd services\ai-ml\tensorflow-jupyterlab

REM Build the image (first time)
build.bat

REM Start Jupyter Lab
start.bat

REM Access at http://localhost:8889

REM Stop service
stop.bat
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| TENSORFLOW_VERSION | latest | Image version/tag |
| TENSORFLOW_TAG | latest | Base TensorFlow tag (use latest-gpu for GPU) |
| TENSORFLOW_JUPYTER_PORT | 8889 | Web interface port |
| JUPYTER_ENABLE_LAB | yes | Enable Jupyter Lab interface |

Edit `.env` to change `TENSORFLOW_TAG` to `latest-gpu` for GPU support, then rebuild.

## Usage Examples

### Create TensorFlow Notebook

```python
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

# Check TensorFlow version
print(f"TensorFlow version: {tf.__version__}")

# Simple neural network
model = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(784,)),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(10, activation='softmax')
])

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# Load MNIST dataset
mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

# Train model
model.fit(x_train.reshape(-1, 784), y_train, epochs=5)

# Evaluate
model.evaluate(x_test.reshape(-1, 784), y_test)
```

### Data Visualization

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv('data.csv')

# Create visualizations
sns.scatterplot(data=df, x='feature1', y='feature2')
plt.show()
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| tensorflow-workspace | /workspace | Notebooks, datasets, models | 5-50GB |
| tensorflow-keras | /keras | Keras model cache and weights | 1-10GB |

**Volume Management:**
```bash
# Backup notebooks
docker run --rm -v tensorflow-workspace:/data -v $(pwd):/backup ubuntu tar czf /backup/tf-notebooks-backup.tar.gz /data

# Remove volumes
docker compose down -v
```

## Use in Compositions

```yaml
services:
  tf-jupyter:
    extends:
      file: ../../services/ai-ml/tensorflow-jupyterlab/docker-compose.yml
      service: tensorflow-jupyterlab
    networks:
      - ml-network
```

## Documentation

- **TensorFlow**: https://www.tensorflow.org/
- **Keras**: https://keras.io/
- **Jupyter Lab**: https://jupyterlab.readthedocs.io/

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.tensorflow-jupyterlab`

---

**Service Type:** AI/ML Development Environment
**Category:** ai-ml
**Deployment:** Requires custom image build

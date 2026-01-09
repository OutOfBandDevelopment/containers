#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Removing AI Workspace stack from Swarm..."
docker stack rm ai-workspace

echo "AI Workspace stack removed. Data preserved in volumes."

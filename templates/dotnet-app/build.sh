#!/bin/bash
# Generic .NET Docker build script
# Usage: ./build.sh <project-name> <dll-name> [dotnet-version] [image-tag]

set -e

# Parameters
PROJECT_NAME=${1:-"MyApp.WebApi"}
DLL_NAME=${2:-$PROJECT_NAME}
DOTNET_VERSION=${3:-"8.0"}
IMAGE_TAG=${4:-"${PROJECT_NAME,,}:latest"}

# Validate parameters
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: PROJECT_NAME is required"
    echo "Usage: $0 <project-name> [dll-name] [dotnet-version] [image-tag]"
    echo "Example: $0 MyApp.WebApi MyApp.WebApi 8.0 myapp:latest"
    exit 1
fi

echo "=========================================="
echo "Building .NET Docker Image"
echo "=========================================="
echo "Project Name:    $PROJECT_NAME"
echo "DLL Name:        $DLL_NAME"
echo ".NET Version:    $DOTNET_VERSION"
echo "Image Tag:       $IMAGE_TAG"
echo "=========================================="

# Build the image
docker build \
    --build-arg DOTNET_VERSION="$DOTNET_VERSION" \
    --build-arg PROJECT_NAME="$PROJECT_NAME" \
    --build-arg DLL_NAME="$DLL_NAME" \
    -t "$IMAGE_TAG" \
    -f Dockerfile \
    .

echo ""
echo "✓ Build complete!"
echo "  Image: $IMAGE_TAG"
echo ""
echo "To run:"
echo "  docker run -p 8080:80 $IMAGE_TAG"

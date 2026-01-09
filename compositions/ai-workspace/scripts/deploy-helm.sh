#!/bin/bash
set -e

cd "$(dirname "$0")/.."

NAMESPACE="${1:-ai-workspace}"
ENVIRONMENT="${2:-dev}"

echo "=========================================="
echo "Deploying AI Workspace (Kubernetes/Helm)"
echo "Environment: $ENVIRONMENT"
echo "Namespace: $NAMESPACE"
echo "=========================================="

# Create namespace if it doesn't exist
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

# Deploy with Helm
echo "Installing/upgrading Helm release..."
helm upgrade --install ai-workspace ./helm \
    --namespace "$NAMESPACE" \
    --values ./helm/values.yaml \
    --values "./helm/values-$ENVIRONMENT.yaml" \
    --wait \
    --timeout 10m

echo ""
echo "=========================================="
echo "AI Workspace Status"
echo "=========================================="
kubectl get pods -n "$NAMESPACE"

echo ""
echo "=========================================="
echo "Services"
echo "=========================================="
kubectl get svc -n "$NAMESPACE"

echo ""
echo "=========================================="
echo "Access Instructions"
echo "=========================================="
if [ "$ENVIRONMENT" == "dev" ]; then
    echo "Port forward nginx service:"
    echo "  kubectl port-forward -n $NAMESPACE svc/ai-workspace-nginx 8080:80"
    echo ""
    echo "Then access:"
    echo "  Open WebUI:    http://localhost:8080/"
    echo "  Ollama API:    http://localhost:8080/ollama/"
    echo "  SearXNG:       http://localhost:8080/searxng/"
    echo "  Apache Tika:   http://localhost:8080/tika/"
else
    echo "Access via ingress: https://ai.yourdomain.com/"
fi
echo ""
echo "Uninstall: helm uninstall ai-workspace -n $NAMESPACE"
echo "=========================================="

#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
NAMESPACE=${2:-ai-ml}

echo "=========================================="
echo "Deploying Vector Search RAG (Helm)"
echo "Environment: ${ENVIRONMENT}"
echo "=========================================="

cd "$(dirname "$0")/.."

kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install \
  vector-search-rag \
  ./helm \
  --namespace ${NAMESPACE} \
  --values ./helm/values-${ENVIRONMENT}.yaml \
  --wait

echo ""
echo "Deployment complete!"
echo ""
kubectl get pods -n ${NAMESPACE}

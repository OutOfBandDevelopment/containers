#!/bin/bash
#
# Docker Asset Scanner
# Scans all repositories for Dockerfiles and docker-compose files
# Generates inventory report for migration planning
#

set -e

OUTPUT_FILE="docker-assets-inventory.md"
SCAN_ROOT="/current/src"

echo "Scanning for Docker assets in $SCAN_ROOT..."
echo ""

# Create header
cat > "$OUTPUT_FILE" << 'EOF'
# Docker Assets Inventory

**Scan Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Scan Root:** /current/src

This inventory identifies all Docker assets across repositories for migration into the containers collection.

---

## Summary

EOF

# Count assets
dockerfile_count=$(find "$SCAN_ROOT" -name "Dockerfile" -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/containers/*" 2>/dev/null | wc -l)
compose_count=$(find "$SCAN_ROOT" -name "docker-compose*.yml" -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/containers/*" 2>/dev/null | wc -l)
dockerignore_count=$(find "$SCAN_ROOT" -name ".dockerignore" -not -path "*/.git/*" -not -path "*/containers/*" 2>/dev/null | wc -l)

# Add summary
cat >> "$OUTPUT_FILE" << EOF
| Asset Type | Count |
|:-----------|------:|
| Dockerfiles | $dockerfile_count |
| Docker Compose Files | $compose_count |
| .dockerignore Files | $dockerignore_count |

---

## Dockerfiles Found

EOF

# Scan for Dockerfiles
echo "Scanning for Dockerfiles..."
find "$SCAN_ROOT" -name "Dockerfile" -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/containers/*" 2>/dev/null | sort | while read -r dockerfile; do
    dir=$(dirname "$dockerfile")
    rel_path=${dir#$SCAN_ROOT/}

    # Determine if public or private
    if [[ "$rel_path" == private/* ]] || [[ "$rel_path" == Cadwell/* ]] || [[ "$rel_path" == Eliassen/* ]]; then
        privacy="PRIVATE"
    else
        privacy="PUBLIC"
    fi

    # Extract base image
    base_image=$(grep "^FROM" "$dockerfile" 2>/dev/null | head -1 | cut -d' ' -f2 || echo "Unknown")

    # Count lines
    lines=$(wc -l < "$dockerfile")

    echo "### $rel_path" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "| Field | Value |" >> "$OUTPUT_FILE"
    echo "|:------|:------|" >> "$OUTPUT_FILE"
    echo "| **Location** | \`$dockerfile\` |" >> "$OUTPUT_FILE"
    echo "| **Privacy** | $privacy |" >> "$OUTPUT_FILE"
    echo "| **Base Image** | \`$base_image\` |" >> "$OUTPUT_FILE"
    echo "| **Size** | $lines lines |" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"

    # Check for multi-stage build
    if grep -q "^FROM.*AS" "$dockerfile" 2>/dev/null; then
        echo "**Build Type:** Multi-stage build" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi

    # List stages if multi-stage
    stages=$(grep "^FROM.*AS" "$dockerfile" 2>/dev/null | sed 's/.*AS //' || true)
    if [ -n "$stages" ]; then
        echo "**Build Stages:**" >> "$OUTPUT_FILE"
        echo "\`\`\`" >> "$OUTPUT_FILE"
        echo "$stages" >> "$OUTPUT_FILE"
        echo "\`\`\`" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi

    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

# Scan for docker-compose files
echo "Scanning for docker-compose files..."
cat >> "$OUTPUT_FILE" << EOF

## Docker Compose Files Found

EOF

find "$SCAN_ROOT" -name "docker-compose*.yml" -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/containers/*" 2>/dev/null | sort | while read -r composefile; do
    dir=$(dirname "$composefile")
    rel_path=${dir#$SCAN_ROOT/}
    filename=$(basename "$composefile")

    # Determine if public or private
    if [[ "$rel_path" == private/* ]] || [[ "$rel_path" == Cadwell/* ]] || [[ "$rel_path" == Eliassen/* ]]; then
        privacy="PRIVATE"
    else
        privacy="PUBLIC"
    fi

    # Count services
    service_count=$(grep -E "^  [a-z]" "$composefile" 2>/dev/null | grep -v "^  #" | wc -l || echo "0")

    # Count lines
    lines=$(wc -l < "$composefile")

    echo "### $rel_path/$filename" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "| Field | Value |" >> "$OUTPUT_FILE"
    echo "|:------|:------|" >> "$OUTPUT_FILE"
    echo "| **Location** | \`$composefile\` |" >> "$OUTPUT_FILE"
    echo "| **Privacy** | $privacy |" >> "$OUTPUT_FILE"
    echo "| **Services** | ~$service_count services |" >> "$OUTPUT_FILE"
    echo "| **Size** | $lines lines |" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"

    # List services
    services=$(grep -E "^  [a-z]" "$composefile" 2>/dev/null | grep -v "^  #" | sed 's/:$//' | sed 's/^  //' || true)
    if [ -n "$services" ]; then
        echo "**Services:**" >> "$OUTPUT_FILE"
        echo "\`\`\`" >> "$OUTPUT_FILE"
        echo "$services" >> "$OUTPUT_FILE"
        echo "\`\`\`" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi

    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

# Scan for .dockerignore files
echo "Scanning for .dockerignore files..."
cat >> "$OUTPUT_FILE" << EOF

## .dockerignore Files Found

EOF

find "$SCAN_ROOT" -name ".dockerignore" -not -path "*/.git/*" -not -path "*/containers/*" 2>/dev/null | sort | while read -r ignorefile; do
    dir=$(dirname "$ignorefile")
    rel_path=${dir#$SCAN_ROOT/}

    # Determine if public or private
    if [[ "$rel_path" == private/* ]] || [[ "$rel_path" == Cadwell/* ]] || [[ "$rel_path" == Eliassen/* ]]; then
        privacy="PRIVATE"
    else
        privacy="PUBLIC"
    fi

    # Count patterns
    patterns=$(grep -v "^#" "$ignorefile" 2>/dev/null | grep -v "^$" | wc -l || echo "0")

    echo "- **$rel_path** ($privacy, $patterns patterns)" >> "$OUTPUT_FILE"
done

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Migration recommendations
cat >> "$OUTPUT_FILE" << EOF

## Migration Recommendations

### High Priority (Public Assets - Easy Migration)

1. **RunScripts** - Docker wrapper patterns (if Dockerfiles exist)
2. **CQRS-Examples** - .NET microservices example
3. **Learning projects** - Educational examples

**Action:** Can be migrated immediately, no sanitization required.

### Medium Priority (Private Assets - Requires Sanitization)

1. **ContainerStore (eliassen)** - AI/ML development stack
2. **Private repositories** - Various Docker assets

**Action:** Requires PII sanitization before migration. Use \`/current/src/private/client-name-scanner.sh\` to verify.

### Low Priority

1. Assets from deprecated or inactive projects
2. Highly client-specific configurations

**Action:** Review and decide case-by-case.

---

## Next Steps

1. **Review this inventory** - Identify migration priorities
2. **Public assets:** Migrate following migration-guide.md
3. **Private assets:** Sanitize using protocols in migration-guide.md, then migrate
4. **Update catalogs:** Keep docs/image-catalog.md and docs/compose-catalog.md synchronized

---

*Generated: $(date +"%Y-%m-%d %H:%M:%S")*
*Scan root: $SCAN_ROOT*
*Total Dockerfiles: $dockerfile_count*
*Total Compose files: $compose_count*
*Total .dockerignore files: $dockerignore_count*
EOF

echo ""
echo "Scan complete!"
echo "Results written to: $OUTPUT_FILE"
echo ""
echo "Summary:"
echo "  Dockerfiles: $dockerfile_count"
echo "  Docker Compose files: $compose_count"
echo "  .dockerignore files: $dockerignore_count"
echo ""

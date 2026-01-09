# PlantUML Server

Web-based PlantUML diagram rendering server with REST API support.

## Overview

PlantUML Server provides a web interface and REST API for rendering PlantUML diagrams. It supports all PlantUML diagram types (sequence, class, activity, component, state, object, deployment, timing, network, and more). Perfect for documentation systems, CI/CD pipelines, and interactive diagram editing.

## Features

- **Web Interface**: Interactive diagram editor with live preview
- **REST API**: Programmatic diagram generation
- **Multiple Formats**: PNG, SVG, ASCII art, and more
- **No Installation**: Browser-based, no local PlantUML installation needed
- **URL Encoding**: Generate diagrams from encoded URLs
- **Lightweight**: Fast rendering for documentation workflows

## Quick Start

```bash
cd services/dev-tools/plantuml
./start.sh

# Access at http://localhost:8080
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| PLANTUML_VERSION | latest | Image version/tag |
| PLANTUML_PORT | 8080 | Web interface port |

## Usage Examples

### Web Interface

Visit http://localhost:8080 and paste your PlantUML code into the editor.

### REST API

#### Render PNG

```bash
# Create diagram text
cat > diagram.txt << 'EOF'
@startuml
Alice -> Bob: Hello
Bob -> Alice: Hi
@enduml
EOF

# Encode and render
ENCODED=$(echo "@startuml" | plantuml -encodeurl)
curl -o diagram.png "http://localhost:8080/png/$ENCODED"
```

#### Render SVG

```bash
curl -X POST \
  http://localhost:8080/svg \
  -H 'Content-Type: text/plain' \
  -d '@startuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response
@enduml'
```

### Python Integration

```python
import requests
import base64

diagram = """
@startuml
class User {
  +String name
  +String email
  +login()
  +logout()
}
@enduml
"""

# Generate SVG
response = requests.post(
    'http://localhost:8080/svg',
    headers={'Content-Type': 'text/plain'},
    data=diagram
)

with open('diagram.svg', 'w') as f:
    f.write(response.text)
```

### Node.js Integration

```javascript
const axios = require('axios');
const fs = require('fs');

const diagram = `
@startuml
[*] --> Active
Active --> Inactive
Inactive --> [*]
@enduml
`;

axios.post('http://localhost:8080/png', diagram, {
    headers: {'Content-Type': 'text/plain'},
    responseType: 'arraybuffer'
})
.then(response => {
    fs.writeFileSync('diagram.png', response.data);
    console.log('Diagram saved');
});
```

### CLI Usage with curl

```bash
# Component diagram
curl -X POST http://localhost:8080/png \
  -H 'Content-Type: text/plain' \
  -d '@startuml
[User Interface] --> [Business Logic]
[Business Logic] --> [Database]
@enduml' -o component.png

# Deployment diagram
curl -X POST http://localhost:8080/svg \
  -H 'Content-Type: text/plain' \
  -d '@startuml
node "Web Server" {
  [Nginx]
  [App Server]
}
database "PostgreSQL" {
  [Database]
}
@enduml' -o deployment.svg
```

## API Endpoints

| Endpoint | Method | Description |
|:---------|:-------|:------------|
| / | GET | Web interface |
| /png | POST | Render diagram as PNG |
| /svg | POST | Render diagram as SVG |
| /txt | POST | Render diagram as ASCII art |
| /png/{encoded} | GET | Render encoded diagram as PNG |
| /svg/{encoded} | GET | Render encoded diagram as SVG |

## Diagram Types

PlantUML supports numerous diagram types:

- **Sequence diagrams** - Message flows between actors
- **Class diagrams** - Object-oriented class structures
- **Activity diagrams** - Workflows and processes
- **Component diagrams** - System components and dependencies
- **State diagrams** - State machines
- **Object diagrams** - Object instances
- **Deployment diagrams** - Infrastructure topology
- **Timing diagrams** - Timing constraints
- **Network diagrams** - Network topology
- **Mind maps** - Hierarchical ideas
- **Gantt charts** - Project timelines

## Use in Compositions

```yaml
services:
  plantuml:
    extends:
      file: ../../services/dev-tools/plantuml/docker-compose.yml
      service: plantuml
    networks:
      - app-network
```

## Documentation Integration

### Markdown + PlantUML

Many documentation tools support PlantUML:

```markdown
<!-- Markdown with PlantUML reference -->
![Architecture](http://localhost:8080/png/ENCODED_DIAGRAM)
```

### Sphinx Integration

```python
# conf.py
extensions = ['sphinxcontrib.plantuml']
plantuml_server_url = 'http://localhost:8080'
```

### MkDocs Integration

```yaml
# mkdocs.yml
markdown_extensions:
  - pymdownx.superfences:
      custom_fences:
        - name: plantuml
          class: uml
          format: !!python/name:plantuml_markdown.PlantUMLMarkdownExtension
```

## Documentation

- **PlantUML**: https://plantuml.com/
- **PlantUML Server**: https://github.com/plantuml/plantuml-server
- **Language Reference**: https://plantuml.com/guide

## Source Tracking

**Migrated from:** shared
**Source commit:** `7e8df998557b15f247aa0fea1444a1d10b1cd2b1`
**Source date:** 2025-10-23
**Source file:** `Scripts/containers/docker-compose.plantuml.yml`

---

**Service Type:** Development Tool
**Category:** dev-tools
**Deployment:** Uses official PlantUML Server image

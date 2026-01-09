# GNU COBOL

GNU COBOL compiler for developing and running COBOL programs in a containerized environment.

## Overview

GNU COBOL (formerly OpenCOBOL) is a free, modern COBOL compiler that translates COBOL programs into C code and compiles it using GCC. This service provides a complete COBOL development environment in a Docker container, perfect for maintaining legacy COBOL applications, learning COBOL, or developing new COBOL programs without installing the compiler locally.

The GNU COBOL compiler supports COBOL 85, COBOL 2002, and COBOL 2014 standards with various extensions. It's actively maintained and suitable for both educational purposes and production use.

## Features

- **GNU COBOL compiler** (cobc): Full COBOL compiler with GCC backend
- **COBOL runtime** (cobcrun): Execute compiled COBOL modules
- **Standards support**: COBOL 85, 2002, and 2014 compliance
- **Interactive development**: Bash shell access for compile-run-debug cycles
- **Persistent workspace**: COBOL source files preserved across container restarts
- **Lightweight**: Minimal Ubuntu 22.04 base with only COBOL tools

## Quick Start

### Linux/macOS

```bash
cd services/dev-tools/gnucobol

# Build the custom image (first time only)
./build.sh

# Start interactive COBOL environment
./start.sh

# You'll be dropped into a bash shell
# Compile and run COBOL programs here
```

### Windows

```batch
cd services\dev-tools\gnucobol

REM Build the custom image (first time only)
build.bat

REM Start interactive COBOL environment
start.bat

REM You'll be dropped into a bash shell
REM Compile and run COBOL programs here
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| COBOL_VERSION | latest | Image version/tag |

Edit `.env` after copying from `.env.template` to customize these values.

## Accessing the Service

This is an **interactive container** that runs a bash shell. Use `docker compose run` or the provided start script:

```bash
./start.sh  # Automatically runs docker compose run
```

Inside the container, you have access to:
- `cobc` - COBOL compiler
- `cobcrun` - COBOL runtime
- `cobol` - COBOL shell

## Usage Examples

### Hello World Program

```bash
# Inside the container
cat > hello.cob << 'EOF'
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO-WORLD.

       PROCEDURE DIVISION.
           DISPLAY "Hello from GNU COBOL!".
           STOP RUN.
EOF

# Compile to executable
cobc -x hello.cob

# Run the program
./hello
```

### Calculate Sum

```bash
# Inside the container
cat > sum.cob << 'EOF'
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULATE-SUM.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NUM1        PIC 9(4) VALUE 1234.
       01  NUM2        PIC 9(4) VALUE 5678.
       01  SUM-RESULT  PIC 9(5).

       PROCEDURE DIVISION.
           ADD NUM1 TO NUM2 GIVING SUM-RESULT.
           DISPLAY "Sum: " SUM-RESULT.
           STOP RUN.
EOF

# Compile and run
cobc -x sum.cob && ./sum
```

### File I/O Example

```bash
# Inside the container
cat > fileio.cob << 'EOF'
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILE-EXAMPLE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUTPUT-FILE ASSIGN TO "output.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  OUTPUT-FILE.
       01  OUTPUT-RECORD     PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-MESSAGE        PIC X(80) VALUE
           "This is a test message written by COBOL.".

       PROCEDURE DIVISION.
           OPEN OUTPUT OUTPUT-FILE.
           MOVE WS-MESSAGE TO OUTPUT-RECORD.
           WRITE OUTPUT-RECORD.
           CLOSE OUTPUT-FILE.
           DISPLAY "File written successfully.".
           STOP RUN.
EOF

# Compile and run
cobc -x fileio.cob && ./fileio

# Check the output file
cat output.txt
```

### Module Compilation

```bash
# Inside the container

# Compile to module (not executable)
cobc -m mymodule.cob

# Use with cobcrun
cobcrun mymodule
```

### Compiler Options

```bash
# Free format source
cobc -x -free hello.cob

# Debug symbols
cobc -x -g hello.cob

# Show warnings
cobc -x -Wall hello.cob

# Specify COBOL standard
cobc -x -std=cobol2014 hello.cob

# List all options
cobc --help
```

## Persistent Volumes

This service uses the following Docker volumes for persistent data:

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| gnucobol-workspace | /workspace | COBOL source files and executables | 100MB-1GB |

**Volume Descriptions:**
- **gnucobol-workspace**: Stores your COBOL source files (.cob, .cbl), compiled executables, and data files

**Backup Recommendations:**
- Back up gnucobol-workspace regularly to preserve your COBOL programs

**Volume Management:**
```bash
# List volumes
docker volume ls | grep gnucobol

# Inspect workspace volume
docker volume inspect gnucobol-workspace

# Backup workspace
docker run --rm -v gnucobol-workspace:/data -v $(pwd):/backup ubuntu tar czf /backup/gnucobol-backup.tar.gz /data

# Remove volumes (WARNING: deletes all COBOL programs)
docker compose down -v
```

## Use in Compositions

To use this service in a composition with `extends`:

```yaml
services:
  cobol-compiler:
    extends:
      file: ../../services/dev-tools/gnucobol/docker-compose.yml
      service: gnucobol
    networks:
      - dev-network
    # Mount additional source directories
    volumes:
      - ./cobol-src:/workspace/src
```

## Health Check

Check if GNU COBOL is installed and working:

```bash
# Check that the image exists
docker images | grep gnucobol

# Verify COBOL compiler version
docker compose run --rm gnucobol cobc --version

# Verify runtime
docker compose run --rm gnucobol cobcrun --version

# Test compilation
docker compose run --rm gnucobol bash -c "
  echo 'IDENTIFICATION DIVISION. PROGRAM-ID. TEST.' > test.cob &&
  echo 'PROCEDURE DIVISION. DISPLAY \"OK\". STOP RUN.' >> test.cob &&
  cobc -x test.cob && ./test
"
```

**Expected healthy state:**
- `cobc --version` shows GNU COBOL version
- Test program compiles and runs successfully

## Documentation

- **GNU COBOL**: https://gnucobol.sourceforge.io/
- **COBOL Standard**: https://www.iso.org/standard/74527.html
- **GnuCOBOL Programmer's Guide**: https://gnucobol.sourceforge.io/HTML/gnucobpg.html
- **COBOL Tutorial**: https://www.tutorialspoint.com/cobol/

## Source Tracking

**Migrated from:** RunScripts
**Source commit:** `859fc4da005996424df7f5cdde45c3d56768b3ad`
**Source date:** 2026-01-09
**Source file:** `MorePower/DockerFile.gnucobol`

**Build from:** Custom Dockerfile (Ubuntu 22.04 with GNU COBOL)

---

**Service Type:** Development Tool (COBOL Compiler)
**Category:** dev-tools
**Deployment:** Requires custom image build, runs interactively

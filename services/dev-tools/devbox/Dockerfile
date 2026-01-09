FROM ubuntu:latest

# Comprehensive development environment with Node.js, .NET, Java, PlatformIO, Go, Rust, and Claude Code CLI

ENV DEBIAN_FRONTEND=noninteractive

# Base utilities and build tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    gnupg \
    software-properties-common \
    lsb-release \
    ca-certificates \
    build-essential \
    unzip \
    apt-transport-https \
    python3 \
    python3-pip \
    python3.12-venv \
    && rm -rf /var/lib/apt/lists/*

# Node.js (LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# .NET 9.0 SDK
RUN add-apt-repository ppa:dotnet/backports -y && \
    apt-get update && \
    apt-get install -y dotnet-sdk-9.0 && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.dotnet:$PATH"
ENV DOTNET_ROOT="/root/.dotnet"
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

# Java 21 (OpenJDK)
RUN add-apt-repository ppa:openjdk-r/ppa -y && \
    apt-get update && \
    apt-get install -y openjdk-21-jdk && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# PlatformIO (for embedded development)
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install -U pip && \
    /opt/venv/bin/pip install -U platformio
ENV PATH="/opt/venv/bin:$PATH"

# Go (configurable version via build arg)
ARG GO_VERSION=1.23.5
ENV GO_VERSION=${GO_VERSION}
RUN curl -LO https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH

# Rust (latest stable via rustup)
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:$PATH"

# Anthropic Claude Code CLI
# https://docs.anthropic.com/en/docs/claude-code/setup
RUN npm install -g @anthropic-ai/claude-code

# Set working directory
WORKDIR /workspace

# Default to bash shell
CMD ["/bin/bash"]

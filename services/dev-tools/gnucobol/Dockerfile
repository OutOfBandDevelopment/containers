FROM ubuntu:22.04

# GNU COBOL compiler for COBOL development

ENV DEBIAN_FRONTEND=noninteractive

# Install GNU COBOL
RUN apt-get update && \
    apt-get install -y gnucobol && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Default to bash shell
CMD ["bash"]

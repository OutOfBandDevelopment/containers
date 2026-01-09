FROM ubuntu:22.04

# Google Chrome with WSLg support for GUI display
# Requires WSL2 with WSLg on Windows, or X11 on Linux

ENV DEBIAN_FRONTEND=noninteractive

# WSLg environment variables (for Windows WSL2)
ENV DISPLAY=:0
ENV WAYLAND_DISPLAY=wayland-0
ENV XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
ENV PULSE_SERVER=/mnt/wslg/PulseServer

# Install dependencies and Google Chrome
RUN apt-get update && \
    apt-get install -y \
        wget \
        curl \
        ncat \
        socat \
    && rm -rf /var/lib/apt/lists/*

# Download and install Google Chrome
WORKDIR /tmp
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get update && \
    apt-get install -y --fix-missing ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Copy startup script
COPY chrome-start.sh /usr/local/bin/start-chrome.sh
RUN chmod +x /usr/local/bin/start-chrome.sh

# Start Chrome with remote debugging
CMD ["/usr/local/bin/start-chrome.sh"]

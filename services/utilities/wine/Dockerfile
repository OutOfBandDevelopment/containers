FROM ubuntu:22.04

# Wine Windows compatibility layer with WSLg support
# Runs Windows applications on Linux with GUI display

ENV DEBIAN_FRONTEND=noninteractive

# WSLg environment variables
ENV DISPLAY=:0
ENV WAYLAND_DISPLAY=wayland-0
ENV XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
ENV PULSE_SERVER=/mnt/wslg/PulseServer

# Install prerequisites
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Add 32-bit architecture support (required for Wine)
RUN dpkg --add-architecture i386

# Add Wine HQ repository
# https://wiki.winehq.org/Ubuntu
RUN mkdir -pm755 /etc/apt/keyrings && \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

# Install Wine stable
RUN apt-get update && \
    apt-get install -y --install-recommends winehq-stable wine wine32 winetricks && \
    rm -rf /var/lib/apt/lists/*

# Initialize Wine prefix (32-bit)
RUN WINEARCH=win32 WINEPREFIX=~/.wine wine wineboot && \
    WINEARCH=win32 WINEPREFIX=~/.wine winetricks -q mfc40

WORKDIR /workspace

CMD ["/bin/bash"]

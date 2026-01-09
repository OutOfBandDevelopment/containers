FROM ubuntu:22.04

# AMD/Xilinx Vivado FPGA Development Environment (Dependencies Only)
# REQUIRES MANUAL INSTALLATION: Download Vivado installer from AMD/Xilinx

ENV DEBIAN_FRONTEND=noninteractive

# WSLg environment variables for GUI support
ENV DISPLAY=:0
ENV WAYLAND_DISPLAY=wayland-0
ENV XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
ENV PULSE_SERVER=/mnt/wslg/PulseServer

# Install Vivado dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        wget \
        libstdc++6 \
        libgtk2.0-0 \
        dpkg-dev \
        python3-pip \
        libtinfo5 \
        libncurses5 \
        openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# NOTE: Place Vivado installer in this directory and uncomment below
# COPY Xilinx_Unified_*.bin /tmp/vivado-installer.bin
# RUN chmod +x /tmp/vivado-installer.bin && \
#     /tmp/vivado-installer.bin --mode unattended --installdir /opt/Xilinx && \
#     rm /tmp/vivado-installer.bin

CMD ["/bin/bash"]

FROM ubuntu:22.04

# Intel Quartus FPGA Development Environment (Dependencies Only)
# REQUIRES MANUAL INSTALLATION: Download Quartus installer from Intel

ENV DEBIAN_FRONTEND=noninteractive

# WSLg environment variables for GUI support
ENV DISPLAY=:0
ENV WAYLAND_DISPLAY=wayland-0
ENV XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
ENV PULSE_SERVER=/mnt/wslg/PulseServer

# Install Quartus dependencies
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

# NOTE: Place Quartus installer in this directory and uncomment below
# COPY Quartus-lite-*.run /tmp/quartus-installer.run
# RUN chmod +x /tmp/quartus-installer.run && \
#     /tmp/quartus-installer.run --mode unattended --installdir /opt/intelFPGA && \
#     rm /tmp/quartus-installer.run

CMD ["/bin/bash"]

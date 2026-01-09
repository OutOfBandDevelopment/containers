FROM ubuntu:22.04

# Multi-kernel Jupyter Lab with Python, .NET, Java, Go, Ruby, and TypeScript/JavaScript support
# Source: https://www.simplified.guide/jupyter-notebook/install-ubuntu

# Update system packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        python3.10 \
        python3.10-dbg \
        python3-pip \
        wget \
        unzip \
        software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter Lab
RUN pip install jupyterlab

# Install Python ML libraries (PyTorch and TensorFlow)
RUN pip install torch torchvision torchaudio tensorflow

# Install .NET Interactive kernel
RUN apt-get update -y && \
    apt-get install -y \
        dotnet-sdk-8.0 \
        aspnetcore-runtime-8.0 \
    && rm -rf /var/lib/apt/lists/*

RUN dotnet tool install --global Microsoft.dotnet-interactive
ENV PATH="$PATH:/root/.dotnet/tools"
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
RUN dotnet interactive jupyter install

# Install Java kernel (IJava)
RUN apt-get update -y && \
    apt-get install -y openjdk-21-jdk && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip --directory-prefix=/tmp/ && \
    unzip /tmp/ijava-1.3.0.zip -d /tmp/ijava && \
    python3 /tmp/ijava/install.py && \
    rm /tmp/ijava-1.3.0.zip && \
    rm -rf /tmp/ijava/

# Install Go kernel (gonb)
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN add-apt-repository ppa:longsleep/golang-backports -y && \
    apt-get update -y && \
    apt-get install -y golang && \
    rm -rf /var/lib/apt/lists/*

RUN go install github.com/janpfeifer/gonb@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    go install golang.org/x/tools/gopls@latest && \
    gonb --install

# Install Ruby kernel (iruby)
ENV PATH=/root/.local/share/gem/ruby/3.0.0/bin:$PATH

RUN apt-get update -y && \
    apt-get install -y libtool libffi-dev ruby ruby-dev make && \
    rm -rf /var/lib/apt/lists/*

RUN gem install --user-install iruby && \
    iruby register --force

# Install TypeScript/JavaScript kernel (tslab)
RUN apt-get update -y && \
    apt-get install -y npm && \
    rm -rf /var/lib/apt/lists/*

RUN npm install --global tslab && \
    tslab install --python=python3

# Expose Jupyter Lab port
EXPOSE 8888

# Start Jupyter Lab without authentication (configure in docker-compose if needed)
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]

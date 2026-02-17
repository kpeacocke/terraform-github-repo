# Multi-platform Terraform Development Container
# Ubuntu 24.04 LTS (noble) - latest stable
# Supports: linux/amd64, linux/arm64 (Apple Silicon compatible)

ARG UBUNTU_VERSION=noble
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    PATH="/usr/local/go/bin:/home/vscode/go/bin:$PATH" \
    GOPATH="/home/vscode/go" \
    GO111MODULE=on

# Install locales first
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Install minimal base dependencies with security scanning
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    unzip \
    jq \
    build-essential \
    pkg-config \
    sudo \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Go (latest stable)
ARG GO_VERSION=1.25.0
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz | \
    tar -xzf - -C /usr/local && \
    rm -rf /usr/local/go/src && \
    go version
ENV PATH="/usr/local/go/bin:${PATH}" \
    GOPATH="/home/vscode/go"

# Install Terraform (latest stable)
ARG TERRAFORM_VERSION=1.5.7
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip -o /tmp/terraform.zip && \
    unzip -q /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip && \
    terraform -version

# Install Python 3 with minimal dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup Python alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Install Ruby with bundler
RUN apt-get update && apt-get install -y --no-install-recommends \
    ruby \
    ruby-dev \
    bundler \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install OPA (Open Policy Agent) - latest
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL -o /usr/local/bin/opa \
    https://openpolicyagent.org/downloads/latest/opa_linux_${ARCH} && \
    chmod +x /usr/local/bin/opa && \
    opa version

# Install Trivy for security scanning (with proper architecture handling)
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then TRIVY_ARCH="64bit"; else TRIVY_ARCH="ARM64"; fi && \
    curl -fsSL "https://github.com/aquasecurity/trivy/releases/download/v0.48.0/trivy_0.48.0_Linux-${TRIVY_ARCH}.tar.gz" | \
    tar -xzf - -C /usr/local/bin trivy && \
    rm -f /usr/local/bin/LICENSE && \
    trivy version

# Install AWS CLI v2
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o /tmp/awscliv2.zip && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip && \
    aws --version

# Install Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Terraform docs
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL https://github.com/terraform-docs/terraform-docs/releases/download/v0.17.0/terraform-docs-v0.17.0-linux-${ARCH}.tar.gz -o /tmp/terraform-docs.tar.gz && \
    tar -xzf /tmp/terraform-docs.tar.gz -C /usr/local/bin terraform-docs && \
    chmod +x /usr/local/bin/terraform-docs && \
    rm /tmp/terraform-docs.tar.gz && \
    terraform-docs version

# Install tfsec (Terraform security scanner)
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL "https://github.com/aquasecurity/tfsec/releases/download/v1.28.1/tfsec-linux-${ARCH}" \
    -o /usr/local/bin/tfsec && \
    chmod +x /usr/local/bin/tfsec && \
    tfsec --version

# Create non-root user with proper permissions
RUN useradd -m -s /bin/bash vscode && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode

WORKDIR /workspace
USER vscode

# Create Go directories with proper permissions
RUN mkdir -p ~/.cache/go-build && \
    mkdir -p ~/go/pkg && \
    mkdir -p ~/go/bin

# Configure shell
RUN echo 'export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"' >> ~/.bashrc && \
    echo 'export GOPATH="$HOME/go"' >> ~/.bashrc

ENTRYPOINT ["/bin/bash"]

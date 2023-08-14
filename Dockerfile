FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive
ARG TERRAFORM_VERSION="1.5.4"

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

RUN apt-get update && apt-get install -y \
        gnupg2 \
        software-properties-common \
        wget \
        build-essential \
        libncursesw5-dev \
        libssl-dev \
        libsqlite3-dev \
        tk-dev \
        libgdbm-dev \
        libc6-dev \
        libbz2-dev \
        libffi-dev \
        zlib1g-dev \
        curl \
        unzip 

RUN add-apt-repository ppa:deadsnakes/ppa && \
        curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

COPY scripts/install_terraform.sh .
RUN ./install_terraform.sh "$TERRAFORM_VERSION"
    
RUN apt-get install -y \
        python3.11 \
        python3-pip \
        nodejs

RUN ln -sf python3 /usr/bin/python && \
    pip3 install --no-cache --upgrade pip setuptools && \
    python3 -m pip install pipenv
    
RUN npm install -g cdktf-cli

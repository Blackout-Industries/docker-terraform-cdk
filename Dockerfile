FROM ubuntu:jammy

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    terraform \
    python3 \
    python3-dev \
    openssh-client \
    curl \
    git

RUN ln -sf python3 /usr/bin/python && \
    python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools && \
    python3 -m pip install pipenv
    
RUN npm install -g cdktf-cli

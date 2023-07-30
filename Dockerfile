FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive
LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

RUN apt-get update && apt-get install -y \
        gnupg \
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
        zlib1g-dev

RUN add-apt-repository ppa:deadsnakes/ppa

RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
        gpg --dearmor | \
        tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
        https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get install -y \
        terraform \
        python3.11        
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 

RUN ln -sf python3 /usr/bin/python && \
    python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools && \
    python3 -m pip install pipenv
    
RUN npm install -g cdktf-cli

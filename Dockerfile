FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION="1.5.4"

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
        curl

RUN add-apt-repository ppa:deadsnakes/ppa

RUN TER_VER="$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')" \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    unzip terraform_${TER_VER}_linux_amd64.zip \ 
    mv terraform /usr/local/bin/
    
RUN apt-get install -y \
        python3.11        
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 

RUN ln -sf python3 /usr/bin/python && \
    python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools && \
    python3 -m pip install pipenv
    
RUN npm install -g cdktf-cli

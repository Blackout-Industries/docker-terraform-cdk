#!/usr/bin/env bash

$TERRAFORM_VERSION="$1"

if [[ $(uname -m) == "x86_64" ]]; then
    wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    mv terraform /usr/local/bin/
elif [[ $(uname -m) =~ "arm" ]]; then
    wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_arm64.zip" && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_arm64.zip" && \
    mv terraform /usr/local/bin/
else
    echo "System architecture is unknown or not supported"
    exit 1
fi
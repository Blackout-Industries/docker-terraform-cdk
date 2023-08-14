# 🐳  Docker | Terraform-CDK 🐳 

## Prerequisites

- Docker installed on your system. You can download and install Docker from the [official Docker website](https://www.docker.com/get-started).

## Getting Started

This image is designed to be used within the pipelines, there is no CMD nor entrypoint

Image is compatible with :

- Azure Devops
- Github
- Gitlab

### Azure Devops

```yaml
- job:
  displayName: "Terraform CDK"
  pool: "ExamplePool01"
  container:
    image: "l33t-sh/docker-terraform-cdk:latest"
    endpoint: "GithubRegistry"
  workspace:
    clean: all
  steps:
    - bash: |
        pipenv install <dependencies>
        pipenv run cdktf deploy --auto-approve '*'
```

### Github
```yaml
cdk:
    name: "CDK.Cloudflare"
    container:
      image: ghcr.io/l33t-sh/docker-terraform-cdk:latest
    ....
    steps:
    ...
    - run: |
        WORKDIR=$(pwd)
        cd ${WORKDIR}/some-cdk-stuff
        pipenv install constructs cdktf ....
        pipenv run cdktf deploy --parallelism  1 "my-stack" --auto-approve
```
### Gitlab TBD

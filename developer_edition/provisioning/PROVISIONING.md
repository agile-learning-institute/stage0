# Stage0 Container Provisioning

This document describes the process for provisioning placeholder container images in the GitHub Container Registry for the stage0 Developer Edition.

## Overview

The stage0 Developer Edition uses multiple microservices, each requiring a container image in the GitHub Container Registry. This provisioning script creates placeholder images using the official `hello-world` container until the actual service images are built and deployed via GitHub Actions.

## Prerequisites
1. Docker Desktop
2. GitHub Authentication
You need to authenticate with the GitHub Container Registry using a Personal Access Token (PAT).

#### Creating a Personal Access Token
1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate a new token with the following permissions:
   - `write:packages` - Required to push container images
   - `read:packages` - Required to read container images
3. Copy the token (you won't be able to see it again)

#### Authenticating with GitHub Container Registry
```bash
# Replace USERNAME with your GitHub username
# Replace TOKEN with your Personal Access Token
export CR_PAT=<token>
export USER_NAME=<github_userid>
echo $CR_PAT | docker login ghcr.io -u $USER_NAME --password-stdin 
```

## Usage

### Basic Usage
```bash
# Create all container images
./provision_containers.sh

```

## Registry Structure

All images are created under the `ghcr.io/agile-learning-institute/` namespace:

## Future Container Management

Once the placeholder images are created, future container updates will be handled by **GitHub Actions**

## References

- [GitHub Container Registry Documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Docker Login Documentation](https://docs.docker.com/engine/reference/commandline/login/)
- [GitHub Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) 
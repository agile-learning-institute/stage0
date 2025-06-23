# Stage0 Provisioning Scripts

This folder contains one-time provisioning scripts for setting up the stage0 Developer Edition infrastructure.

## Overview

These scripts are designed for initial setup and infrastructure provisioning. They are typically run once during the initial setup phase and may be run again if infrastructure needs to be recreated.

## Scripts

### Container Provisioning

**File:** `provision_containers.sh`  
**Purpose:** Creates placeholder container images in GitHub Container Registry  
**Usage:** See [PROVISIONING.md](./PROVISIONING.md) for detailed documentation

```bash
# Create all container images
./provision_containers.sh

# List images that will be created
./provision_containers.sh --list-images

# Verify existing images
./provision_containers.sh --verify-only
```

### Future Scripts

Additional provisioning scripts may be added here for:

- **Repository Provisioning** - Creating GitHub repositories from templates
- **Product Launch** - Provision Repositories, and Merge Templates with Design Specifications
- **Infrastructure Deployment** - Setting up AWS cloud resources for different environments

## Organization

```
provisioning/
├── README.md                    # This file
├── PROVISIONING.md             # Container provisioning documentation
├── provision_containers.sh     # Container image creation script
├── launch.sh                   # Future: GitHub repository creation and merge processing
└── provision_aws.sh            # Future: Cloud Environment configuration 
```

## Prerequisites

- Docker Desktop (for container scripts)
- GitHub Personal Access Token
- Appropriate permissions for the target resources


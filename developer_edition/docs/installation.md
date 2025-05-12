# Installation Guide

## Prerequisites

Before installing stage0 Developer Edition, ensure you have the following installed:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (includes Docker Compose)
- [Python](https://www.python.org/downloads/) 3.9 or later
- [Pipenv](https://pipenv.pypa.io/en/latest/installation/)
- [Node.js](https://nodejs.org/) 18 or later (includes npm)
- [Git](https://git-scm.com/downloads)
- [Make](https://www.gnu.org/software/make/)

## Installation

To install stage0 Developer Edition copy this command and execute it in your terminal window.

```bash
curl -sSL https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/install.sh | bash
```

The script will:
1. Prompt for an installation directory (default: ~/Applications/stage0)
2. Create the installation directory
3. Copy scripts and docker-compose files from Github
4. Set up the stage0 command

## Verifying Installation

To verify your installation, check that the stage0 command is available:
   ```bash
   stage0 version
   ```

## Next Steps

### Discord Bot Requirements

If you plan to develop chat functionality, you'll need review the [Chatbot Contribution Guide](./bot_guide.md) and complete additional configuration steps.

### Review the CLI Users Guide
- [Usage Guide](./usage.md)

### Review the Architecture
- [Service Granularity](./service-granularity.md) standards
- [Service Observability](./service-observability.md) standards
- [Service Configurability](./service-configurability.md) standards

### Review the Development Standards
- [API Development Standards](./api-standards.md) 
- [SPA Development Standards](./spa-standards.md)

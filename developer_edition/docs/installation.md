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

### Quick Installation

To install stage0 Developer Edition, copy this command and execute it in your terminal window:

```bash
curl -sSL https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/install.sh > install.sh && chmod +x install.sh && ./install.sh
```

### What the Installation Does

The installation script will:

1. **Prompt for installation directory** (default: `~/Applications/stage0`)
2. **Create the installation directory** if it doesn't exist
3. **Download required files** from GitHub:
   - `stage0` CLI script
   - `docker-compose.yaml` configuration
4. **Make the CLI executable**
5. **Pull all Docker images** required by the services
6. **Provide PATH configuration instructions**

### Manual Installation

If you prefer to install manually:

```bash
# Download the install script
curl -sSL https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/install.sh > install.sh

# Make it executable
chmod +x install.sh

# Run the installation
./install.sh
```

## Post-Installation Setup

### Add to PATH

After installation, add stage0 to your PATH by adding this line to your shell configuration file:

**For bash (~/.bashrc):**
```bash
export PATH="$HOME/Applications/stage0:$PATH"
```

**For zsh (~/.zshrc):**
```bash
export PATH="$HOME/Applications/stage0:$PATH"
```

**Reload your shell configuration:**
```bash
source ~/.bashrc  # or source ~/.zshrc for zsh
```

## Verifying Installation

To verify your installation, check that the stage0 command is available:

```bash
stage0 version
```

You should see the version number displayed.

## Troubleshooting

### Docker Not Running
If you see "Docker is not running" errors:
1. Start Docker Desktop
2. Wait for Docker to fully initialize
3. Try the installation again

### Permission Issues
If you encounter permission errors:
1. Ensure you have write access to the installation directory
2. Try installing to a different location (e.g., `~/stage0`)
3. Check that Docker Desktop is running with proper permissions

### Network Issues
If Docker image pulling fails:
1. Check your internet connection
2. Ensure Docker can access GitHub Container Registry
3. Run `stage0 update` to retry pulling images

## Next Steps

### Discord Bot Requirements

If you plan to develop chat functionality, you'll need to review the [Chatbot Contribution Guide](./bot_guide.md) and complete additional configuration steps.

### Review the CLI Users Guide
- [Usage Guide](./usage.md)

### Review the Architecture
- [Service Granularity](./service-granularity.md) standards
- [Service Observability](./service-observability.md) standards
- [Service Configurability](./service-configurability.md) standards

### Review the Development Standards
- [API Development Standards](./api-standards.md) 
- [SPA Development Standards](./spa-standards.md)

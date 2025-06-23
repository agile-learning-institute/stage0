#!/bin/bash

# Simple installation:
# curl -sSL https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/install.sh > install.sh && chmod +x install.sh && ./install.sh

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
    echo -e "${GREEN}[+]${NC} $1"
}

# Function to print error messages
print_error() {
    echo -e "${RED}[!]${NC} $1"
}

# Function to print warning messages
print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Function to download a file
download_file() {
    local url=$1
    local output=$2
    print_status "Downloading $(basename "$output")..."
    if ! curl -sSL "$url" -o "$output"; then
        print_error "Failed to download $url"
        return 1
    fi
    return 0
}

# Set default installation directory
DEFAULT_INSTALL_DIR="$HOME/Applications/stage0"

# Prompt for installation directory
read -p "Enter installation directory [$DEFAULT_INSTALL_DIR]: " INSTALL_DIR
INSTALL_DIR=${INSTALL_DIR:-$DEFAULT_INSTALL_DIR}

# Validate installation directory
if [[ -z "$INSTALL_DIR" ]]; then
    print_error "Installation directory cannot be empty"
    exit 1
fi

# Check if we can write to the installation directory
if [[ -e "$INSTALL_DIR" ]] && [[ ! -w "$INSTALL_DIR" ]]; then
    print_error "Cannot write to $INSTALL_DIR. Please choose a different directory or check permissions."
    exit 1
fi

# Create installation directory
print_status "Creating installation directory at $INSTALL_DIR"
if ! mkdir -p "$INSTALL_DIR"; then
    print_error "Failed to create installation directory"
    exit 1
fi

# Verify we can write to the created directory
if [[ ! -w "$INSTALL_DIR" ]]; then
    print_error "Cannot write to $INSTALL_DIR. Please check permissions."
    exit 1
fi

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed or not in PATH"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    print_error "Docker is not running. Please start Docker Desktop."
    exit 1
fi

# Download and set up stage0 command and docker-compose.yaml
print_status "Setting up stage0 command"
if ! download_file "https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/docker-compose.yaml" "$INSTALL_DIR/docker-compose.yaml"; then
    print_error "Installation failed during file download"
    exit 1
fi

if ! download_file "https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/stage0" "$INSTALL_DIR/stage0"; then
    print_error "Installation failed during file download"
    exit 1
fi

# Make stage0 executable
if ! chmod +x "$INSTALL_DIR/stage0"; then
    print_error "Failed to make stage0 executable"
    exit 1
fi

# Verify files were downloaded correctly
if [[ ! -f "$INSTALL_DIR/docker-compose.yaml" ]] || [[ ! -f "$INSTALL_DIR/stage0" ]]; then
    print_error "Installation failed - required files are missing"
    exit 1
fi

# Pull Docker images using stage0 update
print_status "Pulling Docker images..."
if ! "$INSTALL_DIR/stage0" update; then
    print_warning "Some images failed to pull. You can run 'stage0 update' later to retry."
fi

# Clean up temporary install script
if [[ -f "install.sh" ]]; then
    print_status "Cleaning up temporary files..."
    rm -f "install.sh"
fi

print_status "Installation complete!"
print_status "To use stage0, add the following line to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):"
echo -e "${YELLOW}export PATH=\"$INSTALL_DIR:\$PATH\"${NC}"
print_status "Then reload your shell configuration:"
echo -e "${YELLOW}source ~/.bashrc  # or source ~/.zshrc for zsh${NC}"

print_status "You can now use the 'stage0' command from anywhere."
echo -e "${YELLOW}stage0 manual${NC}"

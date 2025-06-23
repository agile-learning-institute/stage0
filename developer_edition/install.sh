#!/bin/bash

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
    curl -sSL "$url" -o "$output"
    if [ $? -ne 0 ]; then
        print_error "Failed to download $url"
        exit 1
    fi
}

# Set default installation directory
DEFAULT_INSTALL_DIR="$HOME/Applications/stage0"

# Prompt for installation directory
read -p "Enter installation directory [$DEFAULT_INSTALL_DIR]: " INSTALL_DIR
INSTALL_DIR=${INSTALL_DIR:-$DEFAULT_INSTALL_DIR}

# Check if we can write to the installation directory
if [ -e "$INSTALL_DIR" ] && [ ! -w "$INSTALL_DIR" ]; then
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
if [ ! -w "$INSTALL_DIR" ]; then
    print_error "Cannot write to $INSTALL_DIR. Please check permissions."
    exit 1
fi

# Download and set up stage0 command and docker-compose.yaml
print_status "Setting up stage0 command"
download_file https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/docker-compose.yaml "$INSTALL_DIR/docker-compose.yaml"
download_file https://raw.githubusercontent.com/agile-learning-institute/stage0/main/developer_edition/stage0 "$INSTALL_DIR/stage0"

# Make stage0 executable
if ! chmod +x "$INSTALL_DIR/stage0"; then
    print_error "Failed to make stage0 executable"
    exit 1
fi

print_status "Installation complete!"
print_status "To use stage0, add the following line to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):"
echo -e "${YELLOW}export PATH=\"$INSTALL_DIR:\$PATH\"${NC}"
print_status "Then reload your shell configuration:"
echo -e "${YELLOW}source ~/.bashrc  # or source ~/.zshrc for zsh${NC}"

print_status "You can now use the 'stage0' command from anywhere."
echo -e "${YELLOW}stage0 manual${NC}"

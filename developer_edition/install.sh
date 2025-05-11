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

# Create installation directory and its subdirectories
print_status "Creating installation directory at $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"/{bin,api,spa,docs}

# Create bin directory for executables
mkdir -p "$INSTALL_DIR/bin"

# Move stage0 to bin directory and make it executable
print_status "Setting up stage0 command"
cp "$0" "$INSTALL_DIR/bin/stage0"
chmod +x "$INSTALL_DIR/bin/stage0"

# Create CURRENT file to track running profiles
touch "$INSTALL_DIR/CURRENT"

# Check prerequisites
print_status "Checking prerequisites..."

# Check Docker
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker Desktop first."
    exit 1
fi

# Check Python
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is not installed. Please install Python 3.9 or later."
    exit 1
fi

# Check Pipenv
if ! command -v pipenv &> /dev/null; then
    print_error "Pipenv is not installed. Please install Pipenv first."
    exit 1
fi

# Check Node.js
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js 18 or later."
    exit 1
fi

# Check Git
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git first."
    exit 1
fi

# Check Make
if ! command -v make &> /dev/null; then
    print_error "Make is not installed. Please install Make first."
    exit 1
fi

# Set up Python virtual environment
print_status "Setting up Python virtual environment"
cd "$INSTALL_DIR/api"
pipenv install

# Install Node.js dependencies
print_status "Installing Node.js dependencies"
cd "$INSTALL_DIR/spa"
npm install

# Create .env file
print_status "Creating environment configuration"
cat > "$INSTALL_DIR/.env" << EOL
# API Configuration
API_HOST=localhost
API_PORT=8000

# Database Configuration
MONGODB_URI=mongodb://localhost:27017/stage0
ELASTICSEARCH_URI=http://localhost:9200

# Kafka Configuration
KAFKA_BOOTSTRAP_SERVERS=localhost:9092

# Service Ports
MONGODB_PORT=27017
ELASTICSEARCH_PORT=9200
KAFKA_PORT=9092
ZOOKEEPER_PORT=2181
EOL

# Create docker-compose.yml
print_status "Creating Docker Compose configuration"
cat > "$INSTALL_DIR/docker-compose.yml" << EOL
version: '3.8'

services:
  mongodb:
    image: mongo:latest
    ports:
      - "27017:27017"
    volumes:
      - mongodb_data:/data/db

  elasticsearch:
    image: elasticsearch:8.11.1
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
    ports:
      - "9200:9200"
      - "9300:9300"
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data

  kafka:
    image: confluentinc/cp-kafka:latest
    depends_on:
      - zookeeper
    ports:
      - "9092:9092"
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: PLAINTEXT
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1

  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    ports:
      - "2181:2181"
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000

volumes:
  mongodb_data:
  elasticsearch_data:
EOL

# Create Makefile
print_status "Creating Makefile"
cat > "$INSTALL_DIR/Makefile" << EOL
.PHONY: run-api run-spa test lint format migrate seed reset-db

run-api:
	cd api && pipenv run python main.py

run-spa:
	cd spa && npm start

test:
	cd api && pipenv run pytest
	cd spa && npm test

lint:
	cd api && pipenv run flake8
	cd spa && npm run lint

format:
	cd api && pipenv run black .
	cd spa && npm run format

migrate:
	cd api && pipenv run alembic upgrade head

seed:
	cd api && pipenv run python seed.py

reset-db:
	cd api && pipenv run python reset_db.py
EOL

print_status "Installation complete!"
print_status "To use stage0, add the following line to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):"
echo -e "${YELLOW}export PATH=\"$INSTALL_DIR/bin:\$PATH\"${NC}"
print_status "Then reload your shell configuration:"
echo -e "${YELLOW}source ~/.bashrc  # or source ~/.zshrc for zsh${NC}"
print_status "You can now use the 'stage0' command from anywhere."
print_status "To start the development environment, run:"
echo -e "${YELLOW}cd $INSTALL_DIR${NC}"
echo -e "${YELLOW}stage0 start${NC}" 
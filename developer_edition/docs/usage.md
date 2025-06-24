# Usage Guide

## Overview

The `stage0` command is a utility for managing the stage0 Developer Edition environment. It provides commands for starting, stopping, and managing services, as well as monitoring and maintenance tasks.

## Basic Commands

```bash
stage0 COMMAND [PROFILE]
```

- `up [profile1,profile2,...]` - Start services for specified profile(s)
- `down` - Stop and remove all containers
- `stop` - Stop currently running profile
- `start` - Restart previously stopped profile
- `logs [service]` - View logs for a service
- `update` - Update stage0 Developer Edition
- `clean` - Remove stage0 containers and images
- `version` - Show version information
- `list-profiles` - List available profiles
- `list-services` - List available services
- `manual` - Show detailed manual
- `uninstall` - Remove stage0 Developer Edition

## Profiles

Profiles allow you to run specific subsets of services. Here are the available profiles:

### Backing Services
- `mongodb` - MongoDB database
- `elasticsearch` - Search optimized database
- `kafka-connect` - Kafka, Zookeeper, and Kafka Connect

### Core Services
All of these profiles start the mongo and/or elasticsearch backing services as needed as well as the API and SPA for the service.
- `search` - Elasticsearch, MongoDB, Search API and SPA
- `mongodb-spa` - MongoDB database configuration API, and SPA
- `cat` - MongoDB, Cat Bot and SPA (Customer Service Representative)
- `fran` - MongoDB, Fran Bot and SPA (Design Thinking Facilitator)
- `paul` - MongoDB, Paul Bot and SPA (Product Manager)
- `sam` - MongoDB, Sam Bot and SPA (Support Engineer)

### Bot-Only Profiles
All of these profiles also start the mongo and/or elasticsearch backing service.
- `search-api` - Search API only
- `mongodb-api` - MongoDB API only
- `cat-bot` - Cat Bot only
- `fran-bot` - Fran Bot only
- `paul-bot` - Paul Bot only
- `sam-bot` - Sam Bot only

### Identity Integration - also starts kafka-connect 
- `identity` - Identity integration API and SPA
- `identity-api` - Identity integration API only

### Special Profiles
- `all` - All services

## Examples

### Starting Services

Start all services:
```bash
stage0 up all
```

Start specific profiles:
```bash
stage0 up search,cat
```

### Managing Services

Stop all services:
```bash
stage0 down
```

View logs for a service:
```bash
stage0 logs search_api
```

### Maintenance

Update to latest version:
```bash
stage0 update
```

Clean up containers and images:
```bash
stage0 clean
```

## Service Ports

For complete port information, see the [Architecture Specification](../../specifications/architecture.yaml).

### Backing Services
- MongoDB: 27017
- Elasticsearch: 9200
- Zookeeper: 2181
- Kafka: 9092, 19092
- Kafka Connect: 9093

## Troubleshooting

### Common Issues

1. **Port Conflicts**
   - Check if ports are already in use
   - Use `stage0 down` to stop all services
   - Restart with `stage0 up [profile]`

2. **Container Issues**
   - Use `stage0 clean` to remove all containers
   - Restart with `stage0 up [profile]`

3. **Update Problems**
   - Run `stage0 update` to get latest version
   - If issues persist, try `stage0 clean` followed by `stage0 up [profile]`

### Getting Help

- Use `stage0 manual` for detailed documentation
- Join our [Discord Server](https://discord.gg/agile-learning-institute) for support

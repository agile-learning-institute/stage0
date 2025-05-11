# Usage Guide

## Overview

The `stage0` command is a utility for managing the stage0 Developer Edition environment. It provides commands for starting, stopping, and managing services, as well as monitoring and maintenance tasks.

## Basic Commands

```bash
stage0 COMMAND 
```

- `up [profile1,profile2,...]` - Start services for specified profile(s)
- `down` - Stop and remove all containers
- `stop [profile1,profile2,...]` - Stop currently running profile
- `start [profile1,profile2,...]` - Restart previously stopped profile
- `tail [service]` - View logs for a service
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
- `mongo-only` - MongoDB database only
- `elasticsearch` - Elasticsearch and related services
- `kafka-connect` - Kafka, Zookeeper, and Kafka Connect

### Core Services
All of these profiles start the mongo and/or elasticsearch backing services as needed as well as the API and SPA for the service.
- `mongo` - MongoDB configuration API and SPA
- `search` - Search API and SPA
- `admin` - User and partner management
- `apprentice` - Curriculum and encounter management
- `mentor` - Topic, path, and plan management
- `identity` - Identity integration services

### API-Only Profiles
All of these profiles also start the mongo and/or elasticsearch backing service.
- `mongo-api` - MongoDB configuration API only
- `search-api` - Search API only
- `admin-api` - Admin API only
- `apprentice-api` - Apprentice API only
- `mentor-api` - Mentor API only
- `identity-api` - Identity API only

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
stage0 up mongo,search,admin
```

### Managing Services

Stop all services:
```bash
stage0 down
```

View logs for a service:
```bash
stage0 tail stage0-search-api
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

Each service runs on a specific port:

### Backing Services
- MongoDB: 27017
- Elasticsearch: 9200
- Zookeeper: 2181
- Kafka: 9092, 19092
- Kafka Connect: 9093

### API Services
- Mongo API: 8080
- Search API: 8082
- Admin API: 8084
- Apprentice API: 8086
- Mentor API: 8088
- Identity API: 8086

### SPA Services
- Mongo SPA: 8081
- Search SPA: 8083
- Admin SPA: 8085
- Apprentice SPA: 8087
- Mentor SPA: 8089
- Identity SPA: 8086

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

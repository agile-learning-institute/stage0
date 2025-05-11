# Service Configurability

This document outlines the principles and guidelines for service configurability in the stage0 platform.

## Configuration Management

### Environment Configuration

1. **Environment Variables**
   ```bash
   # API Configuration
   API_BASE_URL=http://localhost:8000
   API_VERSION=v1
   API_PORT=8000

   # Database Configuration
   MONGODB_URI=mongodb://localhost:27017/stage0
   ELASTICSEARCH_URI=http://localhost:9200

   # Kafka Configuration
   KAFKA_BOOTSTRAP_SERVERS=localhost:9092
   KAFKA_GROUP_ID=stage0-group

   # Service Ports
   MONGODB_API_PORT=8090
   SEARCH_API_PORT=8092
   CAT_API_PORT=8094
   FRAN_API_PORT=8096
   PAUL_API_PORT=8098
   SAM_API_PORT=8100
   ```

2. **Configuration Files**
   - `config.yaml` - Base configuration
   - `config.dev.yaml` - Development environment
   - `config.test.yaml` - Test environment
   - `config.prod.yaml` - Production environment

### Service Configuration

1. **MongoDB API**
   ```yaml
   mongodb:
     uri: ${MONGODB_URI}
     database: stage0
     collections:
       users:
         indexes:
           - fields: ["email"]
             unique: true
       organizations:
         indexes:
           - fields: ["name"]
             unique: true
   ```

2. **Search API**
   ```yaml
   elasticsearch:
     uri: ${ELASTICSEARCH_URI}
     indices:
       users:
         mappings:
           properties:
             name: { type: "text" }
             email: { type: "keyword" }
       organizations:
         mappings:
           properties:
             name: { type: "text" }
             type: { type: "keyword" }
   ```

3. **Kafka Connect**
   ```yaml
   kafka:
     bootstrap_servers: ${KAFKA_BOOTSTRAP_SERVERS}
     group_id: ${KAFKA_GROUP_ID}
     topics:
       user_events:
         partitions: 3
         replication_factor: 1
       organization_events:
         partitions: 3
         replication_factor: 1
   ```

## Feature Flags

### Configuration
```yaml
features:
  enable_search: true
  enable_analytics: false
  enable_notifications: true
  maintenance_mode: false
```

### Usage
```python
from stage0.utils import Config

config = Config.get_instance()
if config.features.enable_search:
    # Enable search functionality
```

## Service Discovery

### Configuration
```yaml
services:
  mongodb:
    host: localhost
    port: 8090
    health_check: /api/v1/health
  search:
    host: localhost
    port: 8092
    health_check: /api/v1/health
  cat:
    host: localhost
    port: 8094
    health_check: /api/v1/health
```

### Service Registration
```python
from stage0.utils import ServiceRegistry

registry = ServiceRegistry.get_instance()
registry.register_service('mongodb', {
    'host': 'localhost',
    'port': 8090,
    'health_check': '/api/v1/health'
})
```

## Logging Configuration

### Log Levels
```yaml
logging:
  level: INFO
  format: "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
  handlers:
    console:
      level: INFO
    file:
      level: DEBUG
      filename: logs/app.log
```

### Log Categories
```yaml
loggers:
  api:
    level: INFO
    handlers: [console, file]
  database:
    level: DEBUG
    handlers: [file]
  security:
    level: WARNING
    handlers: [console, file]
```

## Security Configuration

### Authentication
```yaml
auth:
  jwt:
    secret: ${AUTH_SECRET}
    algorithm: HS256
    expires_in: 3600
  oauth:
    enabled: true
    providers:
      github:
        client_id: ${GITHUB_CLIENT_ID}
        client_secret: ${GITHUB_CLIENT_SECRET}
```

### Authorization
```yaml
authorization:
  roles:
    admin:
      permissions:
        - read:*
        - write:*
    user:
      permissions:
        - read:own
        - write:own
```

## Monitoring Configuration

### Metrics
```yaml
metrics:
  prometheus:
    enabled: true
    port: 9090
  grafana:
    enabled: true
    port: 3000
```

### Alerts
```yaml
alerts:
  email:
    enabled: true
    recipients:
      - admin@example.com
  slack:
    enabled: true
    webhook_url: ${SLACK_WEBHOOK_URL}
```

## Deployment Configuration

### Container Configuration
```yaml
container:
  resources:
    limits:
      cpu: "1"
      memory: "1Gi"
    requests:
      cpu: "500m"
      memory: "512Mi"
  health_check:
    path: /api/v1/health
    interval: 30s
    timeout: 5s
    retries: 3
```

### Scaling Configuration
```yaml
scaling:
  min_replicas: 1
  max_replicas: 5
  target_cpu_utilization: 70
  target_memory_utilization: 80
```

## Best Practices

### Configuration Management
1. **Environment Separation**
   - Use different configs for different environments
   - Never commit sensitive data
   - Use environment variables for secrets

2. **Configuration Validation**
   - Validate config on startup
   - Provide default values
   - Document all configuration options

3. **Dynamic Configuration**
   - Support hot reloading
   - Log configuration changes
   - Maintain configuration history

### Security
1. **Secret Management**
   - Use environment variables for secrets
   - Encrypt sensitive data
   - Rotate secrets regularly

2. **Access Control**
   - Limit configuration access
   - Audit configuration changes
   - Use role-based access

### Monitoring
1. **Configuration Monitoring**
   - Monitor configuration changes
   - Alert on invalid configurations
   - Track configuration usage

2. **Performance Monitoring**
   - Monitor configuration impact
   - Track resource usage
   - Optimize configuration

### Documentation
1. **Configuration Documentation**
   - Document all options
   - Provide examples
   - Include validation rules

2. **Change Management**
   - Document changes
   - Version configurations
   - Maintain changelog 
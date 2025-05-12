# Service Observability Standards

This document outlines the observability standards for stage0 services, including health and config endpoints, Prometheus data collection, and Nginx server logging.

## API Observability

### Health Endpoint

All APIs expose a `/health` endpoint that provides health status information. This endpoint supports Prometheus data collection, allowing for easy integration with monitoring systems.

### Config Endpoint

All APIs expose a `/config` endpoint that provides information about the current configuration items and their sources. This is useful for debugging and understanding the runtime configuration of the service.

## SPA Observability

### Nginx Server Logging

SPAs use the default configuration values for Nginx server logging. This includes access logs and error logs, which are useful for monitoring and debugging.

## Getting Help

- Join our [Discord Server](https://discord.gg/agile-learning-institute)
- Check existing issues and PRs
- Ask in the development channel
- Contact maintainers


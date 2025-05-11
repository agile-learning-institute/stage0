# API Standards

This document outlines the standards for developing and maintaining APIs within the stage0 platform.

## Architecture Overview

#### Micro-service pattern
- Vue.js Single Page Application (SPA) 
- A Python Flask API dedicated to the SPA
- MongoDB backing database

#### The *mongodb* micro-service supports
- Configuration of Indexes and Schema Validation
- Version Migration logic for complex schema changes
- Loading of test data

#### The *search* micro-service leverages
- An **elasticsearch** database
- Event-driven Change Data Capture via Kafka-Connect
- The search-api exposes a batch ETL endpoint

#### Service-Specific Responsibilities
- CAT: User, organization, and product management
- FRAN: Workshop and architecture management
- PAUL: Environment and change request management
- SAM: Incident management

#### Data Dictionary Management
- Each service has exclusive control of specific data collections (dictionaries)
- Services can consume (read) from any collection
- Data validation is implemented at MongoDB collection schema level
- API code should not duplicate validation but may supplement when necessary

## Dependency Management
- All projects use pypi NV for dependency management
- All project related automation is anchored in pipfile scripts
- The following API scripts are Standard
    - ``pipenv run local`` to run the API locally with backing database
    - ``pipenv run test`` to run unittest and generate coverage reports
    - ``pipenv run stepci`` to run stepci end-to-end testing
    - ``pipenv run build`` to package the code for deployment -*Used in Dockerfile*
    - ``pipenv run container`` to build and run a container

## stage0-utils

The **[stage0-utils](https://github.com/agile-learning-institute/stage0-utils)** python pypi module contains code that is shared by multiple APIs. 
- config provides a config singleton object with env and config file support
- flask_utils provides utilities for flask routes
- mongo_utils provides a simple wrapper around the native mongo API

## Project Structure

### File Organization
```
/
├── src/                      # Source code
│   ├── server.py               # Main application entry point
│   ├── routes/                 # HTTP Route definitions
│   │   ├── __init__.py
│   │   └── resource_routes.py
│   └── services/               # Business logic
│       ├── __init__.py
│       └── resource_services.py
└── test/                    # Test files
    ├── test_server.py
    ├── routes/      
    │   ├── __init__.py
    │   └── test_resource_routes.py
    └── services/    
    │   ├── __init__.py
    │   └── test_resource_services.py
    └── stepci.yaml     # API end-to-end testing
```

## RESTful Endpoints
- Use standard HTTP methods:
  - GET: Retrieve resources
  - POST: Create new resources
  - PATCH: Update existing resources
  - DELETE: Rarely Used, typically patch status:archived
- Follow resource-based URL patterns
- Include versioning in URL path (e.g., `/api/v1/resource`)
- Include observability `/api/v1/health` prometheus endpoint
- Include a `/api/v1/config` endpoint for SPA convenience

### Response Format
Successful responses return only the data:
```json
{
  "id": "123",
  "name": "Resource Name",
  "description": "Resource Description"
}
```

Error responses are minimal:
```json
{
  "error": "An error occurred processing your request"
}
```

### Error Handling
- Return generic 500 errors for unexpected issues
- Keep error responses minimal, don't expose not found as 404
- Log detailed errors with correlation IDs
- Log with care, do not to expose PII or secure data

### Event-Driven Communication
- Use Kafka for asynchronous communication
- All mongodb collections have kafka-connect source connectors
- Include correlation IDs in events

## Craftsmanship Standards

### Testing
- All unit testing is done with the python unittest Libraries
- Test coverage should be at least 80%
- End-to-end tests for API endpoints is done using [stepCI](https://github.com/stepci/stepci)
- Use MongoDB and provided test data

### Documentation
- OpenAPI/Swagger documentation is a development contract with the SPA developer
- Keep README.md updated, use ``pipenv run`` for automation
- Document ``curl`` testing commands

### Containerization
- Use multi-stage builds
- Optimize image size
- Do not include test code in container package

### Maintainability
- Follow consistent pep8 coding style guidelines
- Write self-documenting code
- Keep dependencies limited, and updated
- Document architectural decisions in the README 
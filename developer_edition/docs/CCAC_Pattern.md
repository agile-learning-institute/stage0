# Containerized Configuration as Code Pattern

A standardized pattern for building containerized services where **configuration is the product**—not an implementation detail. Configuration lives in source control: versioned, reviewed, diffed, reverted, and promoted. Once configuration reaches a releasable state, it's packaged into a container image that extends a system-level API image. At runtime, nothing mutates. Promotion happens by building and deploying.

This pattern embodies [Intent-First Architecture](https://agile-learning.institute/blog/intent-first-architecture) principles: structure before surface, exploration before hardening, packaging before mutation. The system separates **configuration as the product** (version-controlled files in a repository) from **service delivery** (containerized API + UI).

## Core Architecture

```
Configuration Repository (git) → [Mounts/Bundles] → API Container → RESTful API → SPA Container → Browser
```

Users create their own configuration repositories from templates. The API service reads configurations either from mounted volumes (development) or bundled files (deployment). In deployment mode, configurations are immutable—changes require building and deploying a new container image.

## Standard Structure

### Four-Repository Pattern

Each implementation consists of four repositories:

1. **Umbrella Repository** (main entry point, e.g., `mongodb_configurator`, `stage0_runbooks`)
   - Main entry point and documentation hub for intent and documentation
   - Contains `docker-compose.yaml` for quick-start/playground
   - Provides playground configuration for users to try the system
   - Links to template, API, and SPA repositories
   - Contains documentation (README.md, SRE.md, pattern docs)

   Note: This separation isn't fragmentation—it's containment. Different concerns evolve at different rates, and craftsmanship respects that reality instead of hiding it behind a monorepo that feels simpler until it isn't.

2. **Template Repository** (`*_template`)
   - Contains sample configuration files
   - Includes Dockerfile, docker-compose.yaml, Makefile
   - Users fork/clone this to create their configuration repository
   - Provides both development and deployment profiles

3. **API Repository** (`*_api`)
   - Flask/FastAPI service that reads configuration files
   - RESTful API for CRUD operations on configurations
   - Processes/validates configuration files
   - Can read from mounted volumes or bundled files

4. **SPA Repository** (`*_spa`)
   - Single-page web application (Vue.js/React)
   - Consumes API via REST endpoints
   - Provides user interface for managing configurations
   - Environment variables configure API connection

### Configuration Repository Organization

Configuration files are organized in folders within a `configurator/` or `runbooks/` directory:

**Runbook System:**
```
runbooks/
├── Runbook.md
├── SimpleRunbook.md
└── ...
```

**Configurator System:**
```
configurator/
├── configurations/    # Main configuration files
├── dictionaries/      # Supporting data structures
├── enumerators/       # Enumeration definitions
├── types/            # Type definitions
├── migrations/       # Migration scripts
├── test_data/        # Test fixtures
└── api_config/       # API-specific config files
```

## API Service Pattern

### Configuration Management (`config.py`)

- Centralized `Config` class (singleton pattern)
- Priority: configuration files → environment variables → defaults
- Automatic logging configuration via `LOG_LEVEL`
- Secret masking in `config_items` tracking
- Configuration categories: `config_strings`, `config_ints`, `config_booleans`, `config_string_secrets`
- Default input path: `/input` or `/workspace/runbooks` (configurable via `INPUT_FOLDER`/`RUNBOOKS_DIR`)

### File I/O Pattern (`file_io.py`)

- Abstraction layer for reading/writing configuration files
- Supports YAML and JSON formats
- File operations scoped to folders within the input directory
- Structured error handling with event tracking
- File metadata tracking (name, size, modification time)

### Service Layer Pattern (`*_services.py`)

- Service classes extend a base service class
- CRUD operations for configuration entities
- Processing/validation logic separated from routes
- Event-based error tracking
- Static methods for bulk operations

### Route Pattern (`*_routes.py`)

- Blueprint-based route organization
- RESTful endpoint design (GET, POST, PUT, PATCH, DELETE)
- Event decorators for audit logging
- Local-only enforcement for write operations (`config.assert_local()`)
- JSON request/response format

## Container Design

### API Dockerfile Standard

```dockerfile
FROM python:3.12-slim
WORKDIR /opt/[service_name]
COPY Pipfile Pipfile.lock* ./
RUN pip install pipenv && pipenv install --deploy --system
COPY [src]/ /opt/[service_name]/
ENV PYTHONPATH=/opt/[service_name]
RUN pip install gunicorn
RUN useradd --create-home --shell /bin/bash app && \
    chown -R app:app /opt/[service_name]
USER app
EXPOSE [API_PORT]
CMD ["gunicorn", "--bind", "0.0.0.0:[API_PORT]", "--timeout", "10", "--preload", "[module]:app"]
```

### SPA Dockerfile Standard

```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Deployment Modes

#### Development Mode (Volume Mount)

Configuration repository mounted as volume:

```yaml
services:
  api:
    image: ghcr.io/org/[service]_api:latest
    volumes:
      - ./configurator:/input  # or ./runbooks:/workspace/runbooks
    environment:
      INPUT_FOLDER: /input
      # or RUNBOOKS_DIR: /workspace/runbooks
```

#### Deployment Mode (Packaged)

Configuration files bundled into container image. **At runtime, nothing mutates.** Promotion happens by building and deploying. This single constraint eliminates entire classes of failure:

```dockerfile
# In template repository Dockerfile
FROM ghcr.io/org/[service]_api:latest AS base
COPY configurator/ /input/
# or COPY runbooks/ /workspace/runbooks/
```

Once configuration reaches a releasable state, it's packaged into a container image that extends the system-level API image. The configuration becomes immutable at runtime—all changes require building and deploying a new image. This ensures consistency between development and production, eliminates runtime drift, and makes rollback trivial (deploy the previous image).

## Docker Compose Patterns

### Template Repository docker-compose.yaml

Provides both development and deployment profiles:

**Development Profile:**
- Mounts local configuration directory as volume
- Enables live editing of configurations
- API reads from mounted volume

**Deployment Profile:**
- Uses packaged container image
- No volume mounts
- API reads from bundled files

### Service Communication

```yaml
services:
  api:
    environment:
      API_PORT: 8081
      INPUT_FOLDER: /input  # or RUNBOOKS_DIR: /workspace/runbooks
  
  spa:
    environment:
      API_HOST: api
      API_PORT: 8081
    depends_on:
      api:
        condition: service_healthy
```

The SPA configures API connection via environment variables, which are processed at container startup to generate API client configuration.

## Configuration Management

### Environment Variable Pattern

- All configuration via environment variables
- Sensible defaults for development/testing
- Required variables validated at startup
- Optional variables with fallbacks
- Secret values masked in logs

### Common Variables

- `LOG_LEVEL` / `LOGGING_LEVEL`: Logging verbosity (default: INFO)
- `INPUT_FOLDER` / `RUNBOOKS_DIR`: Primary input path
- `API_PORT`: API service port
- `API_HOST`: API hostname (for SPA)
- Service-specific: `MONGO_CONNECTION_STRING`, `JWT_SECRET`, etc.

## Design Principles

1. **Configuration is the Product**: Configuration that lives in source control is not an implementation detail—it is the product. It's versioned, reviewed, diffed, reverted, and promoted.

2. **Runtime Immutability**: At runtime, nothing mutates. Promotion happens by building and deploying. This single constraint eliminates entire classes of failure.

3. **Intent-First Sequencing**: Structure before surface, exploration before hardening, tests before trust, packaging before mutation. See [Intent-First Architecture](https://agile-learning.institute/blog/intent-first-architecture) for the development philosophy.

4. **Containment, Not Fragmentation**: Four repositories (umbrella, template, API, SPA) allow different concerns to evolve at different rates. This respects reality instead of hiding complexity behind a monorepo.

5. **Template-Based**: Users start from template repositories, enabling consistency and best practices.

6. **Dual Mode**: Support both development (volumes, live editing) and deployment (packaged, immutable) workflows.

7. **RESTful API**: Standard HTTP operations for configuration management—the API encodes intent, enforces structure, and makes automation possible.

8. **Auditable**: Event tracking and structured logging throughout for review and debugging.

9. **Testable**: Unit tests for components, integration tests at service boundaries, black-box end-to-end tests against packaged runtime.

## Example Implementations

### Stage0 Runbook System

- **Umbrella**: `stage0_runbooks` (playground and documentation)
- **Template**: `stage0_template_runbook` (markdown runbooks)
- **API**: `stage0_runbook_api` (Flask, reads `.md` files)
- **SPA**: `stage0_runbook_spa` (Vue.js, manages runbooks)
- **Purpose**: Organize and execute operational procedures

### MongoDB Configurator

- **Umbrella**: `mongodb_configurator` (playground and documentation)
- **Template**: `mongodb_configurator_template` (YAML configurations)
- **API**: `mongodb_configurator_api` (Flask, reads YAML/JSON)
- **SPA**: `mongodb_configurator_spa` (Vue.js, manages MongoDB schemas)
- **Purpose**: Manage MongoDB schema validation and indexing

## Implementation Complexity Considerations

The complexity of API and UI implementation varies significantly based on the nature of the configurations being managed:

### Read-Only Discovery/Execution (Simple Configurations)

When configurations are relatively simple and human-readable, easily consumed and edited directly in an IDE (e.g., markdown files), the API typically exposes **read-only views** of configurations. The primary focus is on **discovery and execution** using those configurations.

**Characteristics:**
- Configuration files are designed for human consumption
- Users edit configurations directly in their IDE/text editor
- API provides read-only access (GET operations)
- UI focuses on browsing, searching, and executing configurations
- No local editing through the UI

**Example:** The runbook system exposes markdown runbooks as read-only resources. Users edit runbooks in their IDE, commit to git, and the API serves them for discovery and execution.

### Local Edit with Sophisticated UI (Complex Configurations)

When configurations become more complex, voluminous, or structured than someone might be able to easily absorb and edit in an IDE, the API supports a **more sophisticated UI** that makes it easier to edit and test configurations locally. After local editing and validation, configurations are packaged into a read-only deployment artifact.

**Characteristics:**
- Configuration files are optimized for machine processing (may be less human-friendly)
- API provides full CRUD operations (GET, POST, PUT, PATCH, DELETE)
- UI provides forms, validation, and guided editing workflows
- Local editing through the UI, with validation and testing capabilities
- Configurations packaged for read-only deployment after local development

**Example:** The MongoDB Configurator provides a sophisticated UI for editing complex YAML schema definitions, with validation, versioning, and processing pipelines that would be difficult to manage manually in an IDE.

### Important Trade-off

⚠️ **Note:** Transitioning from a read-only UI to a local edit UI often means making the configurations **less friendly for human consumption** (e.g., more structured, more verbose, or requiring specialized knowledge). This is a significant architectural decision that impacts:

- Developer experience and workflow preferences
- Review processes and code review capabilities
- Debugging and troubleshooting approaches
- Learning curve and onboarding complexity

Choose the approach that matches your configuration complexity and team preferences.

## Development Sequence (Intent-First Approach)

The pattern follows a specific development sequence that puts intent ahead of implementation:

1. **CLI First**: Start with a command-line interface. CLIs are honest—they force you to name the problem space, define the verbs that matter, and confront workflows end-to-end. There's no layout to hide behind. If the command structure feels awkward, the domain model usually is too.

2. **API Second**: Once the CLI stabilizes, promote it to an API. Not a CRUD service—an engine. The API exists to encode intent, enforce structure, and make automation possible. It's where rules live, not screens. At this stage, there should still be no UI, and that's deliberate. **Structure comes before surface area.**

3. **UI Last**: Only after the API is refined add a UI. By then, the UI isn't guessing or shaping behavior. It's reflecting decisions that have already survived testing, refactoring, and real usage. The UI becomes obvious because the system already knows what it is, and the API is refined to help the UI implement functionality rather than some assumed implementation.

## Evolution Notes

- **First Generation** (runbooks): Focused on markdown/yaml/json file management, simple read-only discovery/execution
- **Mature Pattern** (configurator): Expanded to complex YAML structures, versioning, processing pipelines, sophisticated local editing UI
- Both systems demonstrate the pattern's flexibility across different configuration types and use cases

The MongoDB Configurator represents the most complete implementation, with versioning, processing pipelines, and complex data structures. The Runbooks pattern represents a token-secured execution environment for strategic deployment.

## Related Patterns

This pattern is closely related to and implements principles from:
- **[Intent-First Architecture](https://agile-learning.institute/blog/intent-first-architecture)**: Structure before surface, review intent before locking in behavior
- **[Containerized CLI Pattern](./CCLI_Pattern.md)**: Pure function executors that can be composed into larger systems

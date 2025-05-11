# Contributing to stage0

Thank you for your interest in contributing to stage0! This document provides guidelines and instructions for development and contribution.

## Development Setup

### Clone and Install

1. Fork the repository:
   ```bash
   git clone https://github.com/agile-learning-institute/stage0.git
   cd stage0/developer_edition
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

### Development Workflow

#### Service Management
```bash
./stage0.sh start     # Start all services
./stage.sh stop      # Stop all services
./stage0.sh restart  # Restart all services
./stage0.sh status   # Check service status
./stage0.sh health   # Check service health
./stage0.sh logs     # View service logs
```

#### Development Tasks
```bash
make run-api    # Run the API server
make run-spa    # Run the SPA server
make test       # Run tests
make lint       # Run linters
make format     # Format code
```

#### Database Management
```bash
make migrate    # Run database migrations
make seed       # Seed database with test data
make reset-db   # Reset database to initial state
```

## Testing

### API Testing
```bash
cd api
source ../venv/bin/activate
pytest
```

### SPA Testing
```bash
cd spa
npm run test
```

## Monitoring

The Developer Edition includes built-in monitoring:

- Service health checks
- Log aggregation
- Metrics collection
- Performance monitoring

## Making Changes

1. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes following the coding standards:
   - Follow PEP 8 for Python code
   - Use ESLint for JavaScript/TypeScript
   - Write tests for new functionality
   - Update documentation as needed

3. Run tests and linting:
   ```bash
   make test
   make lint
   ```

4. Commit your changes:
   ```bash
   git commit -m "Description of changes"
   ```

5. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

6. Create a pull request:
   - Use the PR template
   - Describe your changes
   - Link related issues
   - Request reviews from maintainers

## Code Standards

### Python
- Follow PEP 8 style guide
- Use type hints
- Write docstrings for functions and classes
- Maintain test coverage above 80%

### JavaScript/TypeScript
- Use ESLint configuration
- Follow TypeScript best practices
- Write JSDoc comments
- Maintain test coverage above 80%

### Git
- Use conventional commits
- Write clear commit messages
- Keep commits focused and atomic
- Rebase on main before submitting PRs

## Documentation

- Update README.md for significant changes
- Document new features in docs/
- Update API documentation
- Add comments for complex code

## Review Process

1. All PRs require at least one review
2. CI checks must pass
3. Code coverage must not decrease
4. Documentation must be updated
5. Changes must follow coding standards

## Getting Help

- Join our [Discord Server](https://discord.gg/SzNTstqBH2)
- Check existing issues and PRs
- Ask in the development channel
- Contact maintainers

## License

By contributing to stage0, you agree that your contributions will be licensed under the project's MIT License. 
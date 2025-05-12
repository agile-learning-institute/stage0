# Contributing to stage0

Thank you for your interest in contributing to stage0! This document provides guidelines and instructions for development and contribution. After you've [installed](./installation.md) the mentor hub developer addition CLI You can work on the single repository that you're interested in.

## Development Setup

1. Clone the specific repository you want to work on:
   ```bash
   git clone https://github.com/agile-learning-institute/stage0-{repo-name}.git
   cd stage0-{repo-name}
   ```

3. Use Dependency automatons (i.e. ``pipenv run`` or ``npm run``) to run your code locally or to containerize it and test the containers. See the project README.md for details.

## Development Workflow

### Feature Branch Workflow

1. **Create a Feature Branch**
   - Branch naming: `issue-{number}-{description}` or `feature/{description}`
   ```bash
   git checkout -b issue-123-add-new-feature
   ```

2. **Local Development**
   - Make your changes
   - Run tests locally (see Testing section)
   - Update documentation
   - Commit your changes:
     ```bash
     git commit -m "feat: add new feature (issue #123)"
     ```

3. **Testing Requirements**
   - All unit tests must pass
   - Blackbox tests must be updated and pass
   - Documentation must be updated
   - Code must be formatted and linted

4. **Pull Request Process**
   - Push your branch:
     ```bash
     git push origin issue-123-add-new-feature
     ```
   - Create a Pull Request (PR)
   - For questions or clarifications:
     - Create a Draft PR
     - Tag relevant maintainers
     - Use the PR description to ask questions

5. **Code Review**
   - Request reviews from peers
   - Address review comments
   - Keep your branch up to date with main:
     ```bash
     git fetch origin
     git rebase origin/main
     ```

6. **Merge and Automation**
   - Once approved, your PR will be merged to main
   - GitHub Actions will automatically:
     - Run all unit tests
     - Build containers
     - Publish containers to GitHub Container Registry

## Code Standards
- [Python API Standards](./api-standards.md)
- [Vue SPA Standards](./spa-standards.md)

## Review Process

1. All PRs require at least one review
2. CI checks must pass
3. Code coverage must not decrease
4. Documentation must be updated
5. Changes must follow coding standards

## Getting Help

- Join our [Discord Server](https://discord.gg/agile-learning-institute)
- Check existing issues and PRs
- Ask in the development channel
- Contact maintainers

## License

By contributing to stage0, you agree that your contributions will be licensed under the project's MIT License. 
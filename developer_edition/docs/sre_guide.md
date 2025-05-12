# Stage0 SRE Guide

This guide provides instructions for managing the CI/CD infrastructure for the stage0 developer_edition product.

## CI/CD Infrastructure

### GitHub Actions

The CI/CD pipeline is managed by GitHub Actions. The workflow is defined in the `.github/workflows/ci.yml` file.

#### Workflow Steps

1. **Checkout**: Clones the repository
2. **Setup Make**: Sets up Make environment
3. **Run Tests**: Runs tests using Make
4. **Build Containers**: Builds Docker containers
5. **Publish Containers**: Publishes containers to GitHub Container Registry
6. **Update Documentation**: Updates documentation

### Docker Containers

The Docker containers are built and published to the GitHub Container Registry. The containers are defined in the `docker-compose.yml` file.

#### Container Types

1. **Base Containers**: Containers used as base images for other containers
2. **Service Containers**: Containers for specific services
3. **Development Containers**: Containers for development environments

### Monitoring

The CI/CD pipeline is monitored using GitHub Actions logs and notifications.

#### Monitoring Tools

1. **GitHub Actions Logs**: View logs for each workflow run
2. **GitHub Notifications**: Receive notifications for workflow failures
3. **Discord Notifications**: Receive notifications in the Discord server

## Getting Help

- Join our [Discord Server](https://discord.gg/agile-learning-institute)
- Check existing issues and PRs
- Ask in the development channel
- Contact maintainers

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Microservice architecture maintains a 1-to-1 relationship between a source code repo, and a deployable unit (container/package/etc). 

We use github actions to build containers and push them to the GitHub public container registry

Future CI/CD will use github actions to build and push containers to AWS ECS registries.

Future deployment will be to an EKS Cluster

Container Tagging should drive automation to deploy a container to a tagged environment

Future automation runbooks will "promote" or add tags to containers with an existing tag. (i.e. Promote everything in Test to Staging)

Future automation runbooks will drive infrastructure deployment (i.e. Provision a new Sales01 Environment, then Promote everything in Staging to Sales01)

## Notes on setting up GiHub Container Packages
GitHub Docker Container Registry
We are using the GitHub Docker Container Registry [this article](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) is helpful in understanding that service.

We are using the [Build and push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images) action, in conjunction with the /Dockerfile of each repo.

We use Automatic token authentication to access the registry. See [here](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#using-the-github_token-in-a-workflow) for details.


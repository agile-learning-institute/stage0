# CI/CD Configurations

Microservice architecture maintains a 1-to-1 relationship between a source code repo, and a deployable container or package. 

We use github actions to build containers and push them to the GitHub public container registry

Future CI/CD will use github actions to build and push containers to (public?) AWS ECS registries

Future deployment will be to an EKS Cluster

Container Tagging should drive automation to deploy a container to a tagged environment

Future automation runbooks will "promote" or add tags to containers with an existing tag. (i.e. Promote everything in Test to Staging)

Future automation runbooks will drive infrastructure deployment (i.e. Provision a new Sales01 Environment, then Promote everything in Staging to Sales01)

## Notes on setting up GiHub Container Packages
GitHub Docker Container Registry
We are using the GitHub Docker Container Registry [this article](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) is helpful in understanding that service.

We are using the [Build and push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images) action, in conjunction with the /Dockerfile of each repo.

We use Automatic token authentication to access the registry. See [here](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#using-the-github_token-in-a-workflow) for details.


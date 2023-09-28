# [stageZero](https://agile-learning.institute/stagezero)

stageZero is the software platform that is developed, and supported by members from the [Agile Learning Institute](https://agile-learning.institute). The name comes from rocketry, where stage Zero is the launch-pad that launches stage one. The software platform helps to launch new products, features, or microservices.

- See [here](./specifications/stageZero.md) for stageZero design documentation
- See [here](https://github.com/orgs/agile-learning-institute/repositories?q=stageZero&type=all) for a list of active repositories

## Before Contributing

Since GitHub does not have the concepts of folders to organize repositories, we are using a naming convention to make it easy to find related code. All stageZero repositories should be created in the agile-learning-institute organization. The repositories should follow this convention ```stageZero-[service]-[element]``` where service is a service boundry name such as profile, partner, search, etc. and element is one of ```ui | api | db```. for example ```stageZero-profile-ui``` would contain a Single Page WebApp, that uses the ```stageZero-profile-api``` api, with test data from ```stageZero-profile-db```. Also note that these names are technology agnostic, but the code deployed within a project should be a specific implementation. (i.e. stageZero-search-api could be in any language, but should implemented in only one) - This is a topoic still open for discussion.

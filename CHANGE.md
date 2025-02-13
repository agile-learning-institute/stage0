# stage0 Change Control Environments

Your product will be deployed into cloud environments. Most products have at least development (DEV), test (TEST), staging (STAGE), and production (PROD) environments. Stage0 run books, make it easy to provision a new environment for an activity, such as training, or for a trade show. 
## Tagging Containers

All court code is deployed as containerized workload, And is deployed to a specific environment based on a tag. Run book automations exist for Assigning tags to container images based on some existing selection criteria. For example, promote everything currently in latest to the test environment would add a tag test to all containers with the tag latest. In the same way, I can promote everything that's currently in the test environment to the staging environment. Promoting things to a production environment could be accomplished in the same way, but is typically done using a version level tag that is only applied at the staging environment and beyond.

## Cloud Deployment
Containerized workload
Backing Services 
- MongoDB
- ElasticSearchDB
- ?DataLake?
- Kafka / KafkaConnect CDC
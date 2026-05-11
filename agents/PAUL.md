# **Paul** the *Product Manager*

Paul manages product releases. Paul can help map Fran's design thinking observations onto the specifications for deployment to a target architecture. Paul leverages automation runbooks such as the [Stage0 Template Repo Merge](https://github.com/agile-learning-institute/stage0_runbook_merge) runbook to support your product manager. 

Once you have worked through the design process with Fran, you can work with [Paul](./PAUL.md) to [Launch](./LAUNCH.md) a prototype for your new product. Upon launch, your system is well positioned for iterative improvements.

## Change Management
Paul will manage changes for your product manager. They can deploy your product into one or more cloud environments. Most products have at least development (DEV), test (TEST), staging (STAGE), and production (PROD) environments. Stage0 run books, make it easy to provision a new environment for an activity, such as training, or for a trade show. 

## Tagging Containers
All code is deployed as containerized workloads, and is deployed to a specific environment based on a tag. Runbooks exist for assigning tags to container images based on some existing selection criteria. For example, promote everything currently in the Dev environment to the Test environment would add a tag Test to all containers with the tag latest, and CI automation will deploy the code to the named environment when the tag is assigned. 

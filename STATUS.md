# [stage0](https://agile-learning.institute/stagezero) Status

## [/specifications](./specifications/) 
All specifications are "work in progress" and this is a snapshot as of 4/14/2025.

- [data_catalog.yaml](./specifications/data_catalog.yaml) contains a list of the data dictionaries that describe the data for the product. 
- [product.yaml](./specifications/product.yaml) contains core product information.
- [personas.yaml](./specifications/personas.yaml) contains information about user persona's and RBAC roles.
- [experiences.yaml](./specifications/experiences.yaml) describes the bounded domains that support key hills. 
- [architecture.yaml](./specifications/architecture.yaml) maps experiences and data dictionaries onto microservice domains. 
- [ARCHITECTURE.md](/specifications/ARCHITECTURE.md) contains a mermaid diagram of the stage0 system.

## Repositories of interest
 
- [stage0_cat](https://github.com/agile-learning-institute/stage0_cat) has a README.
- [stage0_fran](https://github.com/agile-learning-institute/stage0_fran) is base-line functional. There are issues listed on the repo, but the most important area that needs improvement is in the engineered prompts. 
- [stage0_paul](https://github.com/agile-learning-institute/stage0_paul) has a README.
- [stage0_sam](https://github.com/agile-learning-institute/stage0_sam) has a README.
- [stage0_mongodb](https://github.com/agile-learning-institute/stage0_mongodb) initializes the mongodb using mongoSchemaManager. This repo will need to be refactored when the stage0_runbook_mongo_init runbook is ready. 
- [stage0_py_utils](https://github.com/agile-learning-institute/stage0_py_utils) is functional with CI to publish to Pypi
- [stage0_runner](https://github.com/agile-learning-institute/stage0_runner) has a README.
- [stage0_runbook_evaluate](https://github.com/agile-learning-institute/stage0_runbook_evaluate) is functional with CI to publish a container
- [stage0_runbook_grader](https://github.com/agile-learning-institute/stage0_runbook_grader) is functional with CI to publish a container
- [stage0_runbook_merge](https://github.com/agile-learning-institute/stage0_runbook_merge) is functional with CI to publish a container
- [stage0_runbook_mongo_elastic](https://github.com/agile-learning-institute/stage0_runbook_mongo_elastic) has a README.
- [stage0_runbook_mongo_init](https://github.com/agile-learning-institute/stage0_runbook_mongo_init) has a README. See [mongoSchemaManager](https://github.com/agile-learning-institute/mongoSchemaManager) for a proof of concept for this runbook.

## Current Repo Templates
- [stage0_template_express_mongo](https://github.com/agile-learning-institute/stage0_template_express_mongo) is pseudo functional.
- [stage0_template_flask_mongo](https://github.com/agile-learning-institute/stage0_template_flask_mongo) has a README

The [mentorHub](https://github.com/agile-learning-institute/mentorHub) platform is a proof of concept for the first architecture to be supported, and is the first source to harvest templates for code generation. 

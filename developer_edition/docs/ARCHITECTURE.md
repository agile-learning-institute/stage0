# stage0 Microservice Architecture

This is the architecture used by Stage0 and the first architecture supported by product launch services.

## Architecture principles. 
The stage0 architecture establishes a separation of concerns that supports engineering specialization. Data engineers are focused on Mongo DB, elastic search, Kafka eventual consistency configurations, and most importantly data quality. API engineers build the software that implements business logic and supports a single page application. The API engineers primary user is the SPA developer. The SPA developer is responsible for the user experience, and the user interface. They may duplicate some validation logic when it's necessary to improve the user experience. They consume only a single API.

#### See also
- [Service Granularity](./docs/service-granularity.md) standards
- [Service Observability](./docs/service-observability.md) standards
- [Service Configurability](./docs/service-configurability.md) standards

# Architecture Diagram

This diagram utilize the [mermaid flowchart library](https://mermaid.js.org/syntax/flowchart.html), you may need to install an IDE plugin to preview these diagrams. The VS Code extension markdown-mermaid is a good option.


```mermaid
flowchart LR
    APIG((External 
    Gateway))
    BUS(Kafka)

    APIG 
    --> SearchSPA([stage0_search_spa])
    --> SearchAPI(stage0_search_api)
    --> SearchService[(ElasticSearch)]
    SearchService <--> BUS

    APIG
    --> MongoSPA([stage0_mongodb_spa])
    --> MongoAPI(stage0_mongo_api)
    --> stage0_mongodb
   
    APIG
    --> AdminSPA([stage_admin_spa])
    --> AdminAPI(stage0_admin_api)
    --> AdminDB[(Bots, 
    Runbooks)]
    --> BUS

    APIG
    --> CatSPA([stage0_cat_spa])
    --> CatBot(stage0_cat_bot)
    --> CatDB[(Customer, 
    Product, 
    Conversation)]
    --> BUS

    APIG
    --> FranSPA([stage0_fran_spa])
    --> FranBot(stage0_fran_bot)
    --> FranDB[(Workshop,
    Specification,
    conversation)]
    --> BUS
    
    APIG
    --> PaulSPA([stage0_paul_spa])
    --> PaulBot(stage0_paul_bot)
    --> PaulDB[(Architecture, 
    Releases,
    conversation)]
    --> BUS
    
    APIG
    --> SamSPA([stage0_sam_spa])
    --> SamBot(stage0_sam_bot)
    --> SamDB[(Incident, 
    Runbook,
    conversation)]
    --> BUS

    APIG
    --> IdentitySPA([stage0_identity_spa])
    --> IdentityAPI([stage0_identity_api])
    --> IdentityDB[(History)]

    IdentityAPI 
    --> KeyCloak>KeyCloak]
    --> BUS

    IdentityAPI <--> BUS

    subgraph stage0_mongodb
        AdminDB
        SamDB
        PaulDB
        FranDB
        CatDB
    end

    click stage0_identity_api href "https://github.com/agile-learning-institute/stage0_identity_api"
    click stage0_identity_spa href "https://github.com/agile-learning-institute/stage0_identity_spa"

    click stage0_mongo_api href "https://github.com/agile-learning-institute/stage0_mongo_api"
    click stage0_mongo_spa href "https://github.com/agile-learning-institute/stage0_mongo_spa"

    click stage0_admin_api href "https://github.com/agile-learning-institute/stage0_admin_api"
    click stage0_admin_spa href "https://github.com/agile-learning-institute/stage0_admin_spa"

    click stage0_search_api href "https://github.com/agile-learning-institute/stage0_search_api"
    click stage0_search_spa href "https://github.com/agile-learning-institute/stage0_search_spa"

    click stage0_cat_bot href "https://github.com/agile-learning-institute/stage0_cat_bot"
    click stage0_cat_spa href "https://github.com/agile-learning-institute/stage0_cat_spa"

    click stage0_fran_bot href "https://github.com/agile-learning-institute/stage0_fran_bot"
    click stage0_fran_spa href "https://github.com/agile-learning-institute/stage0_fran_spa"

    click stage0_paul_bot href "https://github.com/agile-learning-institute/stage0_paul_bot"
    click stage0_paul_spa href "https://github.com/agile-learning-institute/stage0_paul_spa"

    click stage0_sam_bot href "https://github.com/agile-learning-institute/stage0_sam_bot"
    click stage0_sam_spa href "https://github.com/agile-learning-institute/stage0_sam_spa"


```

## Infrastructure

The following diagram identifies the cloud infrastructure used by the stage0 platform.

TODO: Still TBD

```mermaid
flowchart LR
DEV --> TEST --> STAGE --> PROD
```


### DEV

This is a cloud hosted development environment. CI Automation deploys new code directly into this environment. Backing services in this environment are based on containerized database resources which contain test data, and can return to the know starting point by redeploying the containers.

### TEST

This is a cloud hosted testing environment, where end-to-end testing is done to assure the quality of the system before release. This environment also uses containerized backing databases to support automated testing. Once the SQA team determines that the new release has passed quality checks in this environment it can be deployed into the Staging environment.

### STAGE

This is the final Pre-Production environment. In this environment data from the Production environment is replicated into the Staging environment to test database migrations. One last QA check is done in this environment before deploying the release into Production.

### PROD

This is the live production environment.
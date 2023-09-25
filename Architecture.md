# DragonFly Architecture

[TOC]

## Architecture Diagrams

### Service Architecture

<img src="./assets/put-a-pin-in-that.png" alt="Bounded Domains" style="height: 169px; width:110px;"/>

### Continous Integration  (Containerized Change Management)

<img src="./assets/put-a-pin-in-that.png" alt="Container Deployment" style="height: 169px; width:110px;"/>

### Continous Delivery  (Orchestrated Infrastructure)

<img src="./assets/put-a-pin-in-that.png" alt="Orchestrated Infrastructure" style="height: 169px; width:110px;"/>

## Architecture Principles

### What is a Microservice?

While there is no single definition for microservices, a consensus view has evolved over time in the industry. Micro Services are small in size, messaging-enabled, bounded by contexts, autonomously developed, independently deployable, decentralized and built and released with automated processes.

The micorservice principles used by, and deployed with DragonFly are aligned with the following influnces:

- The 12 Factor Application guides
- Operations in Microservice Architectures
- Separation of Concerns
- Development Contracts
- Event Driven Design Patterns
- Service Granularity
- Service Configurability
- Service Disposability
- Service Observability
- Service Diagrams / Data

### The 12 Factor App

The book “The 12 Factor App” by Adam Wiggins has often been sighted as a seminal work in MicroService architectures. Here is a quick review of the factors, and how we are implementing them.

1. Codebase - A single codebase, deployed multiple times, re-use at the executable level 
    - Orchestrated Containers
1. Dependencies - Declarative, not implied
    - pip, npm, nuget, maven - shared code is a dependency
1. Configuration - Describe “The environment” in “the Environment”
    - Configuration and Secret Management in K8S
1. Backing Services - Treat as attached by the platform
    - Orchestrated Infrastructure provides K8S backing services at runtime
1. Build, release run - Simple delivery pipeline consisting of only build-release-run
    - CI Pipelines should be very very simple and standardized by technology. Change management should be acomplished with tagging.
1. Process - Designed and deployed as “Stateless” processes
    - Dockerized means stateless
1. Concurrency - Scale by adding processes
    - (Process) Containers are scaled by K8S
1. Port Binding
    - Simple network configurations using only 1 port in each service is an enforcable Dockerfile standard
1. Disposability
    - Fast startup and shutdown of (processes) containers
    - Build Containers with pre-compiled byte-code when possible
    - Disposability also has implications for service granularity
1. Parity - Dev / Test / Prod should be as similar as possible
    - GitOps management via Tags
1. Logs - Write event streams to StdOut, allow the platform to consume/manage them
    - LogDNA or similar for consolidated log files
1. Admin - Treat deployment configurations as code, in a repository with change history
    - K8S, Terraform, ArgoCI, and other tools exemplify this pattern.

### Operations in Cloud Native World

In the book “Cloud Adoption Playbook” written by a team of IBM Distinguished Engineers (Moe Abdula, Ingo Averdunk, Roland Barcia, Kyle Broan and Ndu Emuchay) they identified several core principles of operations in a cloud native world. Applying these principles is an ongoing exercise, influencing how we design, build and run solutions.

- Blame free culture with Design Thinking Retrospectives
- Embrace Risk, using Service Management techniques
- Actively Manage Service Levels (SLO, SLI, SLA)
- Eliminate Toil, the best part is no part
- Build Observable Systems, establish standards
  - Health and Config endpoints on all API's to include version information, tags, and configuration sources
  - Standardized database schema migration and versioning tools

- Automate Everything
  - If you do it twice, automate it the third time.
  - Build Runbooks to standarize automation
  - Favor Simplicity

### Separation of Concerns

One of the defining characteristics of a MicroService is that it is “autonomously developed” which requires that our architectures separate the design to allow multiple developers to work independently. Our interpretaion of this is to separate our architectures into three different layers (a triplet) that can be unit tested in isolation before being brought together for integration testing. Service boundaries should allow services to be deployed independently. Aside from service granularity, triplets can be thought of as a twist on the Model, View, Controller paradigm. When matched to the Agile Learning career path specialities, the seperation looks like this:

- The Model (Data Guild) is responsible for
  - Stateful Persistence at scale
  - Data Quality
  - Referential Integrity / Distributed Eventual Consistency
  - Data Ingest and View Normalization
  - Defining clear Value Constraints including Uniqueness
  - Defining clear Cardinality Constraints
  - Data Performance optimization
- The View (Design, UI/UX and Mobile Guilds) is responsible for
  - User interactions
  - Simple real-time Computation
  - Consumer of a single API
  - Handles API errors gracefully
  - Can Mock APIs when required
  - Input Validation
- The Controller (API Guild) is responsible for 
  - A Stateless, Restful API
  - Enforcing Access control with Bearer Tokens
  - Business Logic, including Advanced Computation, Neural Algorithms, etc.
  - Complete validation of data - multi-field or complex validation constraints
    - Some validation will be “duplicated” or auto-generated based on JSON schema constraints
    - Some validation will only be done by API layer. Validation constraints at the Data layer should be relaxed relative to the constraints enforced by the API.
- The Operations (SRE Guild)
  - CI/CD with K8S, Helm?, Argo?
  - ? Private ? Docker Container registry
  - ? Private ? Dependency Registries (Pypl, npm, nuget, maven)
  - Dependency Governance?
  - Open Source Service Implementations
    - KeyCloak Identity Service
  
### Development Contracts

Since we have separated our architecture into 3 layers we need to define design contracts that developers can use to succinctly describe the interactions between the layers. The contract between the UI and API is expressed as an Open API Specification (OAS) sometimes known as Swagger. The contract between the Controller and the Model is a set of JSON Schema that define the data structures for both the API and any ORM or Data Access libraries.

A word about API design and the separation of User Interaction and Business Logic. In general the UI should only implement the logic necessary to create a desirable user experience. Business logic should be present in the API or controller layer of the architecture. API design should keep in mind that the user of an API is the UI engineer, and the API should be designed to make the UI engineers job as easy as possible. API’s should be designed to support as few calls as possible to support the user experience. API’s should also have the intelligence to interpret the data being provided, relieving the UI developer of almost all data driven logic. API’s should always define meaningful devault values and behaviors.

### Event Driven / Messaging Enabled

The messaging-enabled application leverages an Asynchronous Service Bus to facilitate loosely coupled integrations within a trusted domain. An event driven architecture may use an event bus to publish and subscribe to events, however in many agile architectures the Database will provide event delivery, allowing asyncronous eventual consistency to becomes a deployment decision rather than a design constraint.

Data Engineers frequently use service bus architectures to support publish/subscribe event platforms with both business systems and big data applications harvesting data from a single event streams.

### Service Granularity

If a MicroService architecture divides the application into microservices one of the first questions that comes up is service granularity. In our opinion, is easy to get carried away and break an application up into dozens of services ( or serverless functions! ) when they would be better addressed with a single API on a single Model. We start by breaking an application up into services that can be independently developed, tested and deployed. We strive for services that are very simple and have 1 user interface, that communicates with 1 API, that uses 1 database. While not all solutions will use this pattern, deviations from this pattern should deserve extra consideration.

When identifying bounded domains there are a number of factors that can influence service size. Isolation of subsystems that have special security or performance requirements is one driving factor. Isolating identity services that have special data protection measures, and isolation of Personally Identifiable Information (PII) from access credentials is a best practice. Isolation of search use cases is another common division based on the impact of search on database performance, and allows for optimization of data structures to support search. Integrations are a third common pattern for isolation based on avoiding run-time dependencies on external services.

Another factor that will influence the granularity of services is the principle of independently developed, tested and deployed components. If a problem space is large enough to require multiple developers to work on any component of that service then that service is probably too large.

### Service Configurability

Microservices are by nature small, and should be viewed as bespoke components of the system. In general, it’s best to minimize configuration options and the development, testing and release complications associated with them. That being said, every service will have need of “secret” configuration values, or other values that describe the environment the service is running in. Our services will always look to environment variables to provide this information. Services that want to support other configuration approaches are encouraged to use this heirarchy, that is if the first is not found, move on to the second and so forth:

- Discrete environment variable values
- Aggregated environment variable
- Aggregated configuration file in an isolated path (/opt/[app]/[ver]/config.json)

Configuration options should be specified on container startup, and managed by K8S. Use of configuration options should be limited to required environmental values. Adding configuration options will require special consideration when designing, building, and running automated testing.

### Service Disposability

Service disposability has two very different meanings within an architecture. The first is pretty straight forward, in an orchestrated container environment the developer should assume that the process will be stopped and started frequently. While the application and containers may in fact have rather long run life, the principle of fast start / stop operations is a key attribute of a service that can be orchestrated effectively.

The second and more esoteric aspect of disposability has to do with the size of the service. The principle is that any recreating a service from scracth may be eaiser than untangling complex code written by a long-gone developer. This principle has a direct impact on the autonomous development aspects of a microservice architecture and dove-tails with the configurability principles.

### Service Observability

While the Docker environment itself can provide visibility into container resource utilization (Memory, CPU, Network and Disk) there are typically additional pieces of information that should be observable within the system. We have adopted a standard of implementing two standard endpoints that expose this additional information.

The Health endpoint is designed to provide information about the health of the service, and follows the standard endpoint definition used by the Promethius monitoring project. This will include information about the state of backing services (Database, ServiceBus, Integration Endpoints etc.) as well as the performance of the services (Usage, Response Time, etc.)

The Config endpoint is designed to provide information about the services configuration at runtime. This includes version and release information, non-secret connection data, container tags, git hashes, dependency information, or other information that describes the API that is running.

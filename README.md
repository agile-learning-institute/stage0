# [stageZero](https://agile-learning.institute/stagezero)

stageZero is the software platform that is developed, and supported by members from the [Agile Learning Institute](https://agile-learning.institute).

## Big Idea

stageZero is a software as a service platform that allows users to design and deploy fully functional MVPs, suitable for continuous improvement, in a matter of hours or days instead of weeks or months. Users will define the application using a guided process to collect information that describes the system requirements and then generate and deploy a MVP that is 80% complete in a matter of minutes. The services generated can be incrementally improved over time. Additional micro-services can be described and added to the solution at any time.

## Repository Naming Conventions

Since GitHub does not have the concepts of folders to organize repositories, we are using a naming convention to make it easy to find related code. All stageZero repositories should be created in the agile-learning-institute organization. The repositories should follow this convention ```stageZero-[service]-[element]``` where service is a service boundry name such as profile, partner, etc. and element is one of ```ui | api | db```. for example ```stageZero-profile-ui``` would contain a Single Page WebApp, that uses the ```stageZero-profile-api``` api, with test data from ```stageZero-profile-db```.

## Personas

- Donna the Designer will run the project and is responsible for collecting design artifacts.
- Pam the Product Manager is the entrepreneur with a great idea and will be the primary client in the relationship. 

---

## Roadmap

### Now

- Donna clicks on a Build MVP button and then a Pseudo MVP is generated and deployed automatically.
  - This is POC, not go-live
  - CI/CD automation to Dev
  - README documented developer experiences. 
  - Simple CRUD (Vue to Go to Mongo) Triplet 
  - DragonUI Container/Control framework
  - GraphQL with Realtime Concurrency

### Next

- Donna logs into a Project Portal and clicks on a create new project button and then she can edit design artifacts online and generate a PseudoMVP. 
- Donna adds an IAM service to the design and then when the application is generated for Pam she receives an invitation to set up her account where she can login, then use a simple Search dashboard to access multiple CRUD UIs that are secured by standards based bearer tokens.
  - Adds Identity Triplet Templates
  - Adds Token to CRUD API and UI Templates
  - Adds Search Triplet Templates
  - Create stageZero WebApp with stageZero
  - Context for Identity, Profile, Project, Experience, Models, Infrastructure, and Layouts

### Later

- Donna adds a Notification Service to the design and then when the application is generated for Pam she can receive an email from the application when key events occur. 
- Pam initiates a multi-person chat conversation with stageZero and her team and then stageZero uses design thinking tools to collect design data and generates a MVP at the end.
- Pam conducts a Mural design thinking workshop and then stageZero scrapes Project Info from the Mural.
- Donna uses draw.io to create/edit a design artifact and then stageZero scrapes Infrastructure Info from the Draw.io diagram. 
- Donna uses a container/component preview app and then she can see what the UI will look like and can create the layouts.yaml file in a more interactive way
- Donna adds an Integrations service to the design and then when the application is generated for Pam she can recieve email notifications of key events
- Donna adds an KafkaConnect service to the design and then when the application is generated a KafkaConnect services is deployed to isolate microservices
- Donna adds a Data Lake to the Services and then when the application is generated a Datalake is provisioned


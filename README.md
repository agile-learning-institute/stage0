# stageZero

## Big Idea

stageZero is a software as a service platform that allows users to design and deploy fully functional MVPs, suitable for continuous improvement, in a matter of hours or days instead of months. Users will define the application using a guided process to collect information that describes the system and then generate and deploy a MVP that is 80% complete in a matter of minutes. The services generated can be incrementally improved over time. Additional micro-services can be described and added to the solution at any time.

---

## Business Case

The service provides a guided experience to collect design artifacts. Clients can choose to self-service and work through a series of editors with prompts to define the requirements for free. 

In future iterations a design thinking chat bot feature can be used to facilitate design-thinking chat-shops to collect data. In the current iteration this could be offered as an outcome based service delivered by a human through chat. 

Other outcome based services could include in-person or on-line facilitateed work-shops to collect and compile the design artifacts. Here are the work-shops that could be offered

- Design Workshop to capture Roadmap and Experience requirements
- Architecture Workshop to capture Infrastructure design
- UX Prototyping Workshop to capture Layouts
- UI Branding/Styling Services

When the design is complete stageZero will generate a functional WebApp that runs live in the cloud for free. The app is live for 90 days, at which time the customer can choose from a monetized package

- Fullly managed service with a dedicated team.
- Source code with warm handoff services to your team.
- Source code with team transformation services.

---

## Personas

- Donna the Designer will run the project and is responsible for collecting design artifacts.
- Pam the Product Manager is the entrepreneur with a great idea and will be the primary client in the relationship. 

---

## Roadmap

### Now

- Donna clicks on a Build MVP button and then a Pseudo MVP is generated and deployed automatically.
  - This is POC, not go-live
  - CI/CD automation, GitLab WebIDE for UI.
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


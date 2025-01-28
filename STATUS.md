# [stageZero](https://agile-learning.institute/stagezero) Status

It's still early days, and this is more of an idea than code. The specificationSchemas folder contains schema's that describe specification document structures. There are sample specification files in the specificationSample folder. The [stageZero-repo-processor](https://github.com/agile-learning-institute/stageZero-repo-processor) is a Proof of Concept implementation of the code generation features. 

The [mongoSchemaManager](https://github.com/agile-learning-institute/mongoSchemaManager) product is also a proof of concept for managing schemas. Stage0 will probably implement a new version of that tool that leverages repo-processor features, so it will be in python.

The [mentorHub](https://github.com/agile-learning-institute/mentorHub) platform is a proof of concept for the first architecture to be supported, and is the first source to harvest templates for code generation. 

We will have a Design Thinking Facilitator AI Persona, or at least one of them. We might also have a scribe persona that only listens and harvests design specification documents. We might also have prompts for different design thinking activities, maybe the same person with a different prompt goal. I've captured some initial ideas about engineered prompts in [genPrompts](./genPrompts/)

# building Stage0 with Stage0
There is already a meta component to the templates in Stage0 - but this is meta-meta-meta - If you want to find the specifications for the Stage0 Cloud Platform you can review the [specifications](./specifications/) Start with the [Data Catalog](./stage0/specifications/catalog.yaml) as Data is King!

If you're a nerd, you can look at the [architecture](./stage0/specifications/architecture.yaml) document to see the architecture specifics. This is where we map technology agnostic data onto a technology specific architecture. 

# [stageZero](https://agile-learning.institute/stagezero)

stageZero is a software platform that uses Artificial Inelegance and Human Centered Design techniques to capture design specifications in a technology agnostic manner, and then combines those specifications with a set of technology specific templates to generate 80% of an MVP in hours instead of weeks. The name comes from rocketry, where stage Zero is the launch-pad that launches stage one. The stage0 software platform helps to launch new products, features, or services.

# Status
It's still early days, and this is more of an idea than code. The specificationSchemas folder contains schema's that describe specification document structures. There are sample specification files in the specificationSample folder. The [stageZero-repo-processor](https://github.com/agile-learning-institute/stageZero-repo-processor) is a Proof of Concept implementation of the code generation features. 

The [mongoSchemaManager](https://github.com/agile-learning-institute/mongoSchemaManager) product is also a proof of concept for managing schemas. Stage0 will probably implement a new version of that tool that leverages repo-processor features, so it will be in python.

The [mentorHub](https://github.com/agile-learning-institute/mentorHub) platform is a proof of concept for the first architecture to be supported, and is the first source to harvest templates for code generation. 

We will have a Design Thinking Facilitator AI Persona, or at least one of them. We might also have a scribe persona that only listens and harvests design specification documents. We might also have prompts for different design thinking activities, maybe the same person with a different prompt goal. I've captured some initial ideas about engineered prompts in [genPrompts](./genPrompts/)


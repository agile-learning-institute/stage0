# Design Specifications

Stage zero product launch features work by capturing a set of technology agnostic design specifications, and combining them with a technology specific architecture to generate and deploy the initial prototype. Design specifications are stored in yaml text files. The current design specifications are:

- The [product](./specifications/specification_schema/product_schema.yaml) specification that describes the product and contains the product roadmap.
- The [personas](./specifications/specification_schema/personas_schema.yaml) specification that documents the user persona's and RBAC roles.
- The [experiences](./specifications/specification_schema/experiences_schema.yaml) specification that groups hills into a user experience that creates or consumes information.
- The [data_catalog](./specifications/specification_schema/data_catalog_schema.yaml) specification that identifies all of the data dictionaries used in the system.
- The [dictionaries](./specifications/dictionaries/) that describe the data structures using the [Simple Schema](./SIMPLE_SCHEMA.md) standards
- The [architecture](./specifications/specification_schema/architecture_schema.yaml) specification that maps design specifications onto a poly-repo microservice implementation. NOTE: Future architecture specifications can leverage different architectures and technologies. 


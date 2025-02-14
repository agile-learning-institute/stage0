# Contributing to Stage0

## Prerequisites 
Install stage0 Desktop Edition
Jump in

## Design Specifications
- see [product.yaml](./specifications/product.yaml) for Stage0 product information including a product roadmap.
- see [data_catalog.yaml](./specifications/data_catalog.yaml) for the catalog of stage0 data structures.
- see [experiences.yaml](./specifications/experiences.yaml) for the key user experiences the system supports.
- see [here](./specifications/personas.yaml) for the Persona's we use to describe key users in the system.

## Stage0 Bot Standard Behavior
- Always participate in DM messages
    - Will need context over-run logic
        - persistent "memory" retained at the beginning of the conversation
        - if the latest message is more than X days old, summarize memory-forward and remove summarized messages
- Invited to other channels with a agent command. This means all bots need to expose a "active channels" list.
    - Will need to implement event listener for delete channel event and remove from "active" list.
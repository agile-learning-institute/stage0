# Service Granularity

This document outlines the principles and guidelines for service granularity in the stage0 platform.

## Core Principles

1. **Domain-Driven Design**
   - Services align with business domains
   - Clear boundaries between services
   - Independent deployment and scaling

2. **Data Ownership**
   - Each service owns its data
   - Services can read data from other services
   - Support for event-driven eventual consistency of data domains for scaling

3. **Backing Services**
   - MongoDB (Port )
   - ElasticSearch (Port )
   - Kafka (Port)
   - Kafka-Connect (Port )

4. **Domain Services**
   - MongoDB Config Service (Ports 8090-8091)
   - Search service (Ports 8092-8093 )
   - CAT Service (Ports 8094-8095)
   - FRAN Service (Ports 8096-8097)
   - PAUL Service (Ports 8098-8099)
   - SAM Service (Ports 8100-8101)
   - Identity Integration Service (Ports 8102-8103)

## Asynchronous Communication
The only cross domain communications occur across a Kafka service bus. One API should never call another API directly. An API, like the identity API, can listen for updates to data from the user Data store to trigger integration functionality. 
- Kafka messaging
- Event-driven updates
- Kafka-Connect Event sourcing
- Change data capture for Search

## Separation of concerns

### Data layer
- Data persistence at scale
- Query performance
- Data quality constraints
- Eventual consistency

### API Layer
- Roll based access control
- Business logic
- Complex data quality constraints

### SPA layer
- User Experience
- Input validation 
- Error handling

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
   - MongoDB 
   - ElasticSearch
   - Kafka
   - Kafka-Connect

4. **Domain Services**
   - MongoDB Configuration Service
   - Search service 
   - CAT Service 
   - FRAN Service
   - PAUL Service
   - SAM Service 
   - Identity Integration Service

## Asynchronous Communication
All cross domain communications occur across a Kafka service bus. One API should never call another API directly, and one SPA should only call one API. An API, like the identity API, can listen for updates to data from the user Data store to trigger integration functionality. 
- Kafka messaging
- Event-driven updates
- Kafka-Connect Event sourcing
- Change data capture for Search (future)

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

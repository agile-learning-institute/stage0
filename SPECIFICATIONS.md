# Design Specifications

## Overview

Stage Zero is a platform that helps you design, build, and run systems. One of its key features is product-launch, which generates initial prototypes by combining technology-agnostic design specifications with technology-specific architecture. This document describes the core specifications that drive the prototype generation process.

## How It Works

The product-launch feature works in two main phases:

1. **Design Phase**: [Fran](./bots/FRAN.md) facilitates design workshops to capture business requirements and data structures in technology-agnostic specifications.
2. **Launch Phase**: Combine specifications with a technology-specific architecture to generate and deploy the prototype.

All specifications are stored as YAML text files, making them:
- Human-readable
- Version-controllable
- Easy to modify
- Technology-agnostic

## Core Specifications
- [Product](#product-specification)
- [Personas](#user-specifications)
- [Experiences](#experience-specifications)
- [Data Catalog](#data-specifications)
- [Data Dictionary](#data-dictionaries)
- [Architecture](#architecture-specification)

### Product Specification
The [product](./specifications/specification_schema/product_schema.yaml) specification defines:
- Product description and goals
- Target market and value proposition
- Product roadmap (now, next, later)
- Key features and capabilities

### User Specifications
The [personas](./specifications/specification_schema/personas_schema.yaml) specification documents:
- User personas (characteristics, goals, pain points)
- Role-Based Access Control (RBAC) definitions
- User permissions and capabilities

### Experience Specifications
The [experiences](./specifications/specification_schema/experiences_schema.yaml) specification defines:
- User experiences and workflows
- Feature groupings (hills)
- Information creation and consumption patterns

### Data Specifications
The [data_catalog](./specifications/specification_schema/data_catalog_schema.yaml) specification:
- Identifies all data dictionaries used in the system

### Data Dictionaries
The [dictionaries](./specifications/dictionaries/) folder contains:
- Detailed data structure definitions
- Field-level specifications
- Validation rules

All dictionaries follow the [Simple Schema](./SIMPLE_SCHEMA.md) standard, which provides:
- Consistent data structure definitions
- Built-in validation rules
- Business-friendly type definitions
- Clear documentation requirements

### Architecture Specification
The [architecture](./specifications/specification_schema/architecture_schema.yaml) specification:
- Maps design specifications to implementation
- Defines microservice boundaries
- Specifies technology choices
- Establishes deployment patterns

Note: While the current implementation uses a poly-repo microservice architecture, the specification system is designed to support different architectural patterns. Future versions may implement:
- Monolithic architectures
- Serverless architectures
- Different technology stacks
- Alternative deployment models

## Glossary

- **Hill**: A meaningful outcome of the system expressed as ***who*** does **what** and then ***WOW***
- **RBAC**: Role-Based Access Control, a method of regulating access to resources
- **Poly-repo**: Multiple repository architecture where deployable component has its own code repository
- **YAML**: YAML Ain't Markup Language, a human-readable data serialization format


# Specification Schema's

# What is a Schema

TODO: Write a brief paragraph that describes the importance of data quality, and the value of a data dictionary. Describe how a schema captures data definitions. 

The primary design specification captured throughout all exercises is a data dictionary that describes all of the data created or consumed by the system. These data structures are documented using a Simple Schema standard. Simple Schema uses a json-schema like data structure, but leverages a custom `type` structure that makes them more accessible to design stakeholders who do not have a software engineering background.

## Data Types

At the core of Simple Schema is the idea of a "Custom Type" that allows data to be described in human terms. The simplest property in a data dictionary has a description, and a type that describes how the value described should be validated. For example

```yaml
home_phone:
    description: A users home phone number
    type: phone
```
describes a data property, called `home_phone` that is validated to be a phone number. 

You may have noticed that we never defined exactly what a phone number is. When we are capturing the dictionaries we simply use `one_word` type names that make sense to a human. Later in the design process we will define that type using the technically terse json schema or bson schema standards. Simple Schema isolates these specifications into custom type definitions. See [Custom Types](#custom-types) and [Primitives](#primitives) below for more information.

## Complex Types
Simple Schema Provides a way to define complex data types that you may already be familiar with for objects and array's. Each data dictionary Will describe an object and its properties. For example:
```yaml
title: Customer
description: A customer who pays for our services
type: object
properties:
    id:
        description: The unique customer identifier
        type: identity
    full_name:
        description: The customer full name
        type: word
    user_name:
        description: The customer user name
        type: sentence
    aliases:
        description: Any alternative names used by the customer
        type: array
        items:
            description: An alias
            type: sentence
```
Defines the term `Customer` To describe a customer using a customer `id`, a `name`, and a list of `aliases`. See [Complex Types](#complex-types) below for additional details. You may have noticed that we used some interesting type names, identity, word, sentence. Any system is free to define its own custom types, however stage zero has identified a number of custom types that are useful in describing data. See [Common Custom Types](#common-custom-types) below for details.

## Enumerated Values

TODO Write a brief paragraph that describes what an enumerated value is and highlight that it's the gold standard for data quality constraints. Then show a snippet of Jason on the defines in a numerator and a separate snippet of simple schema yaml that uses that in an enum type Add forward link to #enumerated-types. Here is some old language for context: Enumerations (defining a property as always having one of a list of enumerated values) are the gold standard with regard to data quality. Every system has enumerators, and stage0 starts out with this in mind. The [enumerators.yaml](../specifications/dictionaries/enumerators.yaml) data dictionary specification describes enumerator values for the system. By declaring a property to be of type enum, you are saying this property is one of the values from the enumerator list specified by the enums property. An enum_array is simply an array of type enum. 

# Specifications
Below you will find the technical specifications for Simple Schema

## Custom Types
TODO Introduce dictionaries/types folder, highlight that custom types can include complex types, but always resolve to a primitive. Here is old language for reference: Custom types provide a recursively rendered implementation of data structures in technology specific variants - i.e. JSON Schema or BSON Schema.

```yaml
name:
    description: A name
    type: sentence
    required: true
```
Description and Type are required and every property must have both. Properties default to optional. If the data is critical to the definition of an object you can specify that it is a required property. ``required: false`` is the default if no value is provided.

### Primitives

TODO: Describe what a type primitive is. Show a yaml snippet

### Common Custom Types
- [word]() A string of up to 32 characters, no special characters like new-lines, tabs, or escaped code, no whitespace.
- [sentence]() A string of up to 255 printable characters, no special characters like new-lines, tabs, or escaped code. Whitespace is allowed.
- [paragraph]() An array of sentences.
- [count]() A non-negative integer 
- [currency]() A USD Currency Value 
- [identity]() A system generated Unique Identifier. 
- [breadcrumb](./specifications/dictionaries/types/breadcrumb.yaml) Data use to track an event (when, who, where, etc) 


## Enumerated Types

Enumerated types are defined in a json file called enumerators.json. For example in the enumerators dictionary. That might include enumerators like:

```yaml
    default_status:
        draft: A record that is not yet active
        active: "An active record
        archived: "A record that has been archived
    tags:
        short: Content less than a 5 min read
        long: Content more than a 5 min read
        violence: Content contains violence
        language: Content contains course language
        adult: Contains adult content
        documentary: Is a documentary
```

### Enum types
```yaml
    status:
        description: The document status
        type: enum
        enums: default_status
        required: true
```
For ``enum`` types, the ``enums`` property is required. Like with simple custom types, the ``required`` property is optional and defaults to false if not provided. 

### Enum Array Types
```yaml
    tags:
        description: Media tags for content
        type: enum_array
        enums: tags
        required: true
```
Where an ``enum`` type represents a single value from the list of enumerated values, an ``enum_array`` type is a list of values from an enumerated list. 

## Complex Types
Complex types contain other types

### Object Types
```yaml
TODO Example
```
TODO Description

### Array Types
```yaml
TODO Example
```
TODO Description

### OneOf Types
```yaml
TODO Example
```
TODO Description



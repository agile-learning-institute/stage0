# Simple Schema language

The primary design specification captured throughout all exercises is a quality data dictionary for all data structures in the system. These data structures are documented using a Simplified Schema structure that can be thought of as json-schema "lite".

The following properties are valid in this simplified schema structure:
```yaml
title: Required on top-level objects specified in the data catalog.
description: Required for ALL properties
type: [array, object, enum, enum_array, one_of, **custom_type**]
items: for array types
properties: for object types
required: for object types
additional_properties: for object types
enums: for enum or enum_array types
one_of: for polymorphic list properties with type indicator
```

Future development may introduce additional properties, but they should be optional. 

## What are enum and enum_array types
Enumerations (defining a property as always having one of a list of enumerated values) are the gold standard with regard to data quality. Every system has enumerators, and stage0 starts out with this in mind. The [enumerators.yaml](../specifications/dictionaries/enumerators.yaml) data dictionary specification describes enumerator values for the system. By declaring a property to be of type enum, you are saying this property is one of the values from the enumerator list specified by the enums property. An enum_array is simply an array of type enum. 

## What are **custom_types**
Any property with a type not shown above will reference a type file of the same name. Custom types provide a recursively rendered implementation of data structures in technology specific variants - i.e. JSON Schema, BSON Schema, Django ORM Model, etc. 

see [breadcrumb.yaml](./specifications/dictionaries/types/breadcrumb.yaml) for an example.

### Custom Types
You can build you own, these are provided for you to use.
- [word]() A string of up to 32 characters, no special characters like new-lines, tabs, or escaped code, no whitespace.
- [sentence]() A string of up to 255 printable characters, no special characters like new-lines, tabs, or escaped code. Whitespace is allowed.
- [paragraph]() An array of sentences.
- [count]() A non-negative integer (0 to TBD)
- [currency]() A USD Currency Value
- [identity]() A system generated Unique Identifier. 



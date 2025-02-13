# Simple Schema language

TODO: Why Data, Data Qualitt.....

Simplified Schema is json-schema "lite"

The following properties are valid in this simplified schema:
```yaml
description: Required for ALL properties
type: [array, object, enum, enum_array, *custom_type*]
items: for array types
properties: for object types
enums: for enum types or enum_array
```

Future development may introduce additional properties, but they should be optional. 

## What are enum and enum_array types
Enumerations (defining a property as always having one of a list of enumerated values) are the gold standard with regard to data quality. Every system has enumerators, and stage0 starts out with this in mind. The [enumerators.yaml](./specifications/dictionaries/enumerators.yaml) data dictionary specification describes enumerator values for the system. 

## What are Custom Types
Any property with a type not shown above will reference a type file of the same name. Custom types provide a recursively rendered implementation of data structures in technology specific variants - i.e. JSON Schema, BSON Schema, Django ORM Model, etc. 

see [breadcrumb.yaml](./specifications/dictionaries/types/breadcrumb.yaml) for an example.

### Custom Types
Build you own, these are provided.
- [word]() A string of up to 32 printable characters with no whitespace characters
- [sentence]() A string of up to 255 printable characters, without any special characters like new-lines, tabs, or escaped code. 
- [paragraph]() An array of sentences.
- [count]() A non-negative integer (0 to ?)
- [currency]() A USD Currency Value
- [identity]() A Unique Identifier or _id value



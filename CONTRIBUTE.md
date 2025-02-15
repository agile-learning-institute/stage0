# Contributing to Stage0

## Prerequisites 
Install stage0 Desktop Edition
Jump in

## Design Specifications
- see [product.yaml](./specifications/product.yaml) for Stage0 product information including a product roadmap.
- see [data_catalog.yaml](./specifications/data_catalog.yaml) for the catalog of stage0 data structures.
- see [experiences.yaml](./specifications/experiences.yaml) for the key user experiences the system supports.
- see [here](./specifications/personas.yaml) for the Persona's we use to describe key users in the system.


## Echo
Echo is a python Chat Agent/Action utility library that implemented stage0 bot standards. 
It will be packaged and published to pypi when it stabilizes
It is modeled after the Flask http library. The chat/agent protocol is based on these standards.
- Agents are invoked with a standard command that is any message that starts with /agent/action that matches a registered action
- Action command messages can optionally include a yaml code block for action arguments. 
- Bot will always participate in DM channels
- Bot will always participate in Text channels from when ``@mention``-ed, until told to ``@mention silent``
- Bot will engage conversationally to provide access to agent actions.
- All conversation persisted in a mongo Conversation Document.
    - Each conversation has a search index for ``channel_id, version`` and new conversation documents have ``version:latest``
    - Context over-run logic - If the latest message is more than X days old, or size > limit:
        - Full conversation document updated ``version: today()"`` 
        - New conversation document ``version:latest`` is created
        - The new conversation is populated with memory and a summary of previous conversation

- Agent Blueprint
    - register_agent_actions [{action_name, description, arguments_schema, outputs_schema}]
    - execute action(message)

- Agent Initialization
    bot = Echo(__name__)
    from src.agents.some_agent import register_agent_actions
    bot.register_blueprint(register_agent_actions(), agent_prefix='/some')
    bot.run(ACCESS_TOKEN)

## Python Coding Standards
- something, something PEP8 unless otherwise noted below
- unittest file naming standards ``source_test.py`` or ``source_sub_test.py`` - see [why not ``test_*``](#why-not-use-test_py)
- use of stage0_utils module (TODO: Extract and publish privately)
    - Config
    - Flask utils
    - Mongo utils
    - LLM utils

### Why not use ``test_*.py``
The goal of our naming convention is to keep testing code grouped closely with the code being tested. 

If our goal was to keep test files grouped together and separated from the source code being tested then we could follow the convention of having identical directory structures under /src and /test with all the test code under the test folder, and the default test file name the exact same name as the file being tested. This effectively keeps all the testing files separated, but organized to make it easy to find the code being tested. This also makes it easier to ensure that unit testing code is not included in deployment packaging.

Since our goal is to have the test code closely grouped to the code that is being tested, we put test files in the same folder with the source code, and using a source_test.py or source_sub_test.py naming pattern to group the source and test files together in a file listing. 

Using the PEP8 standard of test files in the format ``test_*.py`` seems to take the worst of both approaches, it intermingles test code with source code, without keeping test code closely grouped to source code. As a side note, this thinking was heavily influenced by the go lang standards. 
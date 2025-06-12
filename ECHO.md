# Stage0 Echo Bot

## A Multi-Party Conversational AI Framework

All of the Stage0 Bots are built using the Echo agent framework. This allows you to engage a bot using @mention commands. All bot's support the following @mention commands, simply @ the bot with the command, i.e. ``@fran join``
- ``join`` will allow the bot to participate in text conversations in any text channel. 
- ``leave`` will cause the agent to no longer participate in the conversation in this channel.
- ``reset`` will archive the active conversation history, and start a new conversation. Bot latency can increase, and responses may become nonsensical if the conversation over-runs the models context window. Most bot's are designed to support a specific activity, and will not need to be reset within the scope of that activity. Engaging with bots conversationally is encouraged, but occasional resets may be a good idea, specifically in DM channels. 
- ``load {Name}`` will load a personality into the conversation. See the specific Bot's documentation for information about valid personality names.

## Agent Access
The Echo framework also defines an Agent/Action/Arguments syntax that exposes functionality that the Bot can use to lookup information to answer questions or take actions within their specific domain. During normal operation the Bot will manage the details of formatting and laying out commands, and the framework will hide those interactions from you. 

While you will likely never need to use agent commands directly, all of those commands are also available to you in the channel. It's good to know they are there. The chat-bot will have the new information available to them, on the next interaction after using a command. Commands have to be a 1-line message formatted as:
```
/Agent/Action/Arguments 
```
Where {Agent} is an Agent Name, {Action} is an Action name, and Arguments is a JSON parsable string that matches the actions arguments schema. Some commands do not require arguments, but the 3rd / is required.

You can use ``/echo/get_agents/`` to get a list of agents and a description of their actions. The response will be a minified json string, but you should be able to ask the bot to Interpret that information for you.

You can use the get_action action to get the arguments schema for an action, as well as for the reply the agent will give. For example:
```
/echo/get_action/{"agent":"bot", "action":"update_bot"}
```
Will provide the arguments schema needed for the update_bot action.

# Contributing to Bots

## Overview

The stage0 platform includes several Discord bots that work together to provide different functionalities:
- **Cat**: Helps with setup and configuration
- **Fran**: Facilitates design and architecture discussions
- **Paul**: Manages product and project planning
- **Sam**: Provides customer support and feedback

## Development Setup

### 1. Create a Test Discord Server

It's recommended to create your own Discord server for development and testing:

1. Open Discord and click the "+" button in the server list
2. Choose "Create My Own"
3. Select "For me and my friends"
4. Name your server (e.g., "my-stage0-dev")
5. Click "Create"

### 2. Create Discord Applications

For each bot you want to develop:

1. Go to the [Discord Developer Portal](https://discord.com/developers/applications)
2. Click "New Application"
3. Name your application (e.g., "my-stage0-cat-dev")
4. Go to the "Bot" section
5. Click "Add Bot"
6. Under "Privileged Gateway Intents", enable:
   - PRESENCE INTENT
   - SERVER MEMBERS INTENT
   - MESSAGE CONTENT INTENT
7. Copy the bot token (you'll need this later)

### 3. Configure Bot Permissions

For each bot:

1. In the Developer Portal, go to "OAuth2" → "URL Generator"
2. Select the following scopes:
   - `bot`
   - `applications.commands`
3. Select the following bot permissions:
   - Read Messages/View Channels
   - Send Messages
   - Read Message History
   - Use Slash Commands
4. Copy the generated URL
5. Open the URL in a browser
6. Select your test server to add the bot

### 4. Set Up Environment Variables

For each bot you're developing, set the corresponding environment variable:

```bash
# For Cat bot development
export STAGE0_CAT_TOKEN=your_cat_bot_token

# For Fran bot development
export STAGE0_FRAN_TOKEN=your_fran_bot_token

# For Paul bot development
export STAGE0_PAUL_TOKEN=your_paul_bot_token

# For Sam bot development
export STAGE0_SAM_TOKEN=your_sam_bot_token
```

Add these to your shell configuration file (~/.bashrc, ~/.zshrc, etc.) for persistence.

## Development Workflow

1. Start the specific bot's API service:
   ```bash
   stage0 up cat-api  # or fran-api, paul-api, sam-api
   ```

## Testing

1. Use your test Discord server to verify bot functionality
2. Create test channels for different scenarios
3. Use Discord's developer mode to copy message IDs and other details
4. Test both slash commands and message-based interactions

## Best Practices

1. **Isolation**: Use your test server to avoid affecting production bots
2. **Logging**: Enable debug logging during development
3. **Error Handling**: Implement proper error handling and user feedback
4. **Rate Limiting**: Be mindful of Discord's rate limits
5. **Security**: Never commit bot tokens to version control

## Resources

- [Discord Developer Portal](https://discord.com/developers/docs/intro)
- [Discord.py Documentation](https://discordpy.readthedocs.io/)
- [Discord API Documentation](https://discord.com/developers/docs/reference)
- [stage0 Bot Architecture](./service-granularity.md#bot-services)

## Getting Help

- Join our [Discord Server](https://discord.gg/SzNTstqBH2)
- Check the [API Standards](./api-standards.md) for bot development guidelines
- Review the [Service Observability](./service-observability.md) guide for monitoring

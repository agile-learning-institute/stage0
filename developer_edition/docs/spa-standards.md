# SPA Development Standards

This document outlines the standards for developing Single Page Applications (SPAs) in the stage0 platform.

## Technology Stack

- **Framework**: Vue.js
- **Build Tool**: Vue CLI with Webpack
- **UI Library**: Vuetify
- **State Management**: Vuex
- **Routing**: Vue Router
- **HTTP Client**: Axios

## Project Structure

- **src/**: Source code
  - **assets/**: Static assets
  - **components/**: Vue components
  - **views/**: Page components
  - **store/**: Vuex store
  - **router/**: Vue Router configuration
  - **api/**: API client
  - **utils/**: Utility functions

## NPM Automation

Every SPA project must include the following standard NPM scripts:

- **serve**: Start the development server
- **test**: Run unit tests
- **lint**: Run the linter
- **format**: Format the code
- **container**: Build and run the Docker container locally

## Best Practices

- **Component Design**: Use single-file components
- **State Management**: Use Vuex for global state
- **Routing**: Use Vue Router for navigation
- **API Communication**: Use Axios for HTTP requests
- **Styling**: Use Vuetify for UI components
- **Testing**: Write unit tests for components and store

## Getting Help

- Join our [Discord Server](https://discord.gg/agile-learning-institute)
- Check existing issues and PRs
- Ask in the development channel
- Contact maintainers 
---
name: help
description: "List all available /sc commands and their functionality"
category: utility
complexity: low
mcp-servers: []
personas: []
---

# /sc:help - Display All Commands

## Functionality
The `/sc:help` command provides a comprehensive list of all available SuperClaude (`/sc`) commands. It is designed to help users discover the full range of capabilities of the SuperClaude framework. The command dynamically fetches all registered commands and displays their names and a brief description of their functionality.

## Triggers
- When a user needs to see all available `/sc` commands.
- When a user is unsure of what commands are available.
- When a user is looking for a specific command but does not remember its name.

## Usage
To use the command, simply type `/sc:help` in the chat.

```
/sc:help
```

The command takes no arguments.

## Command Output
The output will be a formatted list of all available `/sc` commands. Each entry in the list will contain:
- The command name (e.g., `/sc:analyze`)
- A brief description of the command's purpose.

The list will be dynamically generated, so it will always be up-to-date with the currently installed commands.

### Example Output
```
Here are the available /sc commands:

- /sc:analyze: Perform a detailed analysis of the codebase.
- /sc:build: Execute the build process for the project.
- /sc:explain: Provide a detailed explanation of a concept or code block.
- /sc:help: Display this list of all available commands.
- ... and so on for all other commands.
```

## Boundaries

**Will:**
- Provide a list of all registered `/sc` commands.
- Display the name and a brief, one-line description of each command.
- Always provide the most up-to-date list of commands.

**Will Not:**
- Execute any other command.
- Provide detailed documentation for each command. For that, use `/sc:explain`.
- Accept any arguments or flags.

## Pro-Tip
For more detailed information on a specific command, use the `/sc:explain` command. For example, to learn more about the `/sc:build` command, you can type:
```
/sc:explain /sc:build
```

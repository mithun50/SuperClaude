# SuperClaude v3 🚀
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)](https://github.com/NomenAK/SuperClaude)
[![GitHub issues](https://img.shields.io/github/issues/NomenAK/SuperClaude)](https://github.com/NomenAK/SuperClaude/issues)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/NomenAK/SuperClaude/blob/master/CONTRIBUTING.md)
[![Contributors](https://img.shields.io/github/contributors/NomenAK/SuperClaude)](https://github.com/NomenAK/SuperClaude/graphs/contributors)

An enhancement framework for Claude Code that adds extra capabilities through specialized commands, personas, and MCP server integration.

**📢 Status**: Initial release, fresh out of beta! Bugs may occur as we continue improving things.

## What is SuperClaude? 🤔

SuperClaude extends Claude Code with:
- 🛠️ **15 specialized commands** for development, analysis, and quality tasks
- 🎭 **Smart personas** that adapt behavior for different domains (frontend, security, architecture, etc.)
- 🔧 **MCP server integration** for documentation lookup, UI components, and browser automation
- 📋 **Enhanced task management** with progress tracking and validation
- ⚡ **Token optimization** for more efficient conversations

We built this because we wanted Claude Code to be even more helpful for software development workflows.

## Current Status 📊

✅ **What's Working Well:**
- Installation suite (completely rewritten, much more reliable)
- Core framework with 9 documentation files 
- 15 slash commands for various development tasks
- MCP server integration (Context7, Sequential, Magic, Playwright)
- Unified CLI installer that actually works

⚠️ **Known Issues:**
- This is an initial release - bugs are expected
- Some features may not work perfectly yet
- Documentation is still being improved
- Hooks system was removed (coming back in v4)

## Key Features ✨

### Commands 🛠️
We've streamlined from 20+ commands down to 15 essential ones:

**Development**: `/build`, `/dev-setup`  
**Analysis**: `/analyze`, `/review`, `/troubleshoot`  
**Quality**: `/improve`, `/scan`, `/test`  
**Others**: `/document`, `/deploy`, `/git`, `/migrate`, `/estimate`, `/task`, `/design`

### Smart Personas 🎭
Auto-activating specialists that adapt Claude's behavior:
- 🏗️ **architect** - Systems design and architecture
- 🎨 **frontend** - UI/UX and accessibility  
- ⚙️ **backend** - APIs and infrastructure
- 🔍 **analyzer** - Investigation and root cause analysis
- 🛡️ **security** - Threat modeling and vulnerabilities
- ✍️ **scribe** - Documentation and technical writing
- *...and 5 more*

### MCP Integration 🔧
Specialized servers for different tasks:
- **Context7** - Official library documentation and patterns
- **Sequential** - Complex multi-step analysis and reasoning  
- **Magic** - Modern UI component generation
- **Playwright** - Browser automation and E2E testing

## Installation 📦

### Quick Start
```bash
# Clone the repo
git clone <repository-url>
cd SuperClaude

# Install with our unified CLI
python3 SuperClaude.py install --quick

# That's it! 🎉
```

### Other Installation Options
```bash
# Minimal install (just core framework)
python3 SuperClaude.py install --minimal

# Developer setup (everything)  
python3 SuperClaude.py install --profile developer

# Interactive selection
python3 SuperClaude.py install

# See what's available
python3 SuperClaude.py install --list-components
```

The installer handles everything: framework files, MCP servers, and Claude Code configuration.

## How It Works 🔄

SuperClaude enhances Claude Code through:

1. **Framework Files** - Core documentation installed to `~/.claude/` that guides Claude's behavior
2. **Slash Commands** - 15 specialized commands for different development tasks  
3. **MCP Servers** - External services that add capabilities like documentation lookup and UI generation
4. **Smart Routing** - Automatic selection of tools and personas based on your requests

Everything is designed to work seamlessly with Claude Code's existing functionality.

## What's Coming in v4 🔮

We're working on the next version which will include:
- **Hooks System** - Event-driven enhancements (removed from v3, being redesigned)
- **MCP Suite** - Expanded server ecosystem  
- **Better Performance** - Faster response times and smarter caching
- **More Personas** - Additional domain specialists
- **Cross-CLI Support** - Work with other AI coding assistants

## Configuration ⚙️

After installation, you can customize SuperClaude by editing:
- `~/.claude/settings.json` - Main configuration
- `~/.claude/*.md` - Framework behavior files

Most users won't need to change anything - it works well out of the box.

## Contributing 🤝

We welcome contributions! Areas where we could use help:
- 🐛 **Bug Reports** - Let us know what's broken
- 📝 **Documentation** - Help us explain things better  
- 🧪 **Testing** - More test coverage for different setups
- 💡 **Ideas** - Suggestions for new features or improvements

The codebase is pretty straightforward Python + documentation files.

## Project Structure 📁

```
SuperClaude/
├── SuperClaude.py          # Main installer CLI
├── SuperClaude/            # Framework files  
│   ├── Core/              # Behavior documentation (COMMANDS.md, FLAGS.md, etc.)
│   ├── Commands/          # 15 slash command definitions
│   └── Settings/          # Configuration files
├── setup/                 # Installation system
└── profiles/              # Installation profiles (quick, minimal, developer)
```

## Architecture Notes 🏗️

The v3 architecture focuses on:
- **Simplicity** - Removed complexity that wasn't adding value
- **Reliability** - Better installation and fewer breaking changes  
- **Modularity** - Pick only the components you want
- **Performance** - Faster operations with smarter caching

We learned a lot from v2 and tried to fix the things that were frustrating.

## FAQ 🙋

**Q: Why was the hooks system removed?**  
A: It was getting complex and buggy. We're redesigning it properly for v4.

**Q: Does this work with other AI assistants?**  
A: Currently Claude Code only, but v4 will have broader compatibility.

**Q: Is this stable enough for daily use?**  
A: The core features work well, but expect some rough edges since it's a fresh release.

## SuperClaude Contributors

[![Contributors](https://contrib.rocks/image?repo=NomenAk/SuperClaude)](https://github.com/NomenAK/SuperClaude/graphs/contributors)

## License

MIT - [See LICENSE file for details](https://opensource.org/licenses/MIT)

## Star History

<a href="https://www.star-history.com/#NomenAK/SuperClaude&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date" />
 </picture>
</a>
---

*Built by developers, for developers. We hope you find it useful! 🙂*

---

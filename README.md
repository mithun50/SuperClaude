# SuperClaude Framework v3.0

A modular enhancement framework for Claude Code that adds orchestration, quality assurance, and advanced capabilities through a hook-based architecture.

*WORK IN PROGRESS*

## Why SuperClaude v3?

The framework evolved to address several needs:
- **Claude Code Updates**: Anthropic's parsing changes and new hooks feature opened new possibilities
- **Cross-CLI Compatibility**: Architecture designed to work with other agent CLIs beyond Claude Code
- **User Choice**: Modular system lets users pick only the features they need
- **Maintainability**: Reduced over-engineering for easier maintenance

## What's New in v3

### New Modes
- **Sub Agent Mode**: Delegate complex tasks to specialized sub-agents for parallel processing
- **Wave Mode**: Multi-stage execution with compound intelligence across operations
- **Loop Mode**: Iterative refinement for progressive improvements

### Improved Modes
- **Task Management**: Enhanced with cross-session persistence and better state tracking
- **Introspection**: Now includes framework troubleshooting and meta-cognitive analysis
- **Token Reduction**: Smarter compression achieving realistic 30-50% reduction

### Core Architecture Changes
- **Orchestrator**: New intelligent routing system for optimal tool and persona selection
- **Split Core**: Separated Rules (actionable directives) from Principles (philosophy)
- **Scribe Persona**: Professional documentation specialist with localization support
- **Hook System**: 15 specialized hooks for event-driven enhancements

## Installation

Work in progress

## Hook System Implementation

The framework uses 15 Python hooks that intercept Claude Code events:

### Core Infrastructure Hooks
- `wave_coordinator.py` - Manages wave orchestration lifecycle
- `performance_monitor.py` - Tracks execution metrics in real-time
- `context_accumulator.py` - Manages context across operations
- `error_handler.py` - Provides graceful error recovery
- `hook_registry.py` - Manages hook lifecycle and dependencies

### Feature Hooks
- `mcp_coordinator.py` - Integrates MCP servers (Context7, Sequential, Magic, Playwright)
- `task_manager.py` - Enhanced task lifecycle management
- `token_optimizer.py` - Intelligent token usage optimization
- `agent_manager.py` - Sub-agent lifecycle and coordination

### Quality Hooks
- `quality_validator.py` - Enforces quality gates
- `quality_gates_coordinator.py` - 8-step validation cycle
- `result_collector.py` - Aggregates and validates results
- `synthesis_engine.py` - Generates compound intelligence

Hooks are configured in `settings.json` and respond to events:
- `PreToolUse` - Before any tool executes
- `PostToolUse` - After tool completion
- `SubagentStop` - When sub-agents complete
- `Stop` - Session end
- `Notification` - System notifications

# Install MCP servers globally
python Scripts/install_mcp_servers.py

Servers auto-activate based on task context or can be manually controlled with flags.

## Command Consolidation

Streamlined from 20+ commands to 14 essential ones:

### Development
- `/build` - Project building with framework detection
- `/dev-setup` - Environment configuration

### Analysis
- `/analyze` - Multi-dimensional analysis (wave-enabled)
- `/review` - Code review and quality analysis (wave-enabled)
- `/troubleshoot` - Problem investigation

### Quality
- `/improve` - Evidence-based enhancement (wave-enabled)
- `/scan` - Security and quality scanning (wave-enabled)
- `/test` - Testing workflows

### Others
- `/document`, `/deploy`, `/git`, `/migrate`, `/estimate`, `/task`

## Configuration

### Global Settings
The framework installs to `~/.claude/` with:
- `settings.json` - Required settings
- `hooks/` - All Python hooks
- `commands/` - Slash commands
- Core markdown files (COMMANDS.md, FLAGS.md, etc.)

### Customization
Edit `settings.json` to:
- Enable/disable specific hooks
- Configure MCP servers
- Set performance thresholds
- Customize wave behavior
- Define custom routing rules

## Roadmap

### In Progress
- Modular installation script for feature selection
- Comprehensive test battery for each component
- Wiki and user guides

### Planned Improvements
- Further leverage of hooks system for extensibility
- Reduce framework complexity where possible
- Cross-CLI compatibility layer

## Contributing

We welcome contributions! Key areas:
- Test coverage for hooks and modes
- Documentation and examples
- Performance optimizations
- Cross-CLI compatibility

## Architecture Notes

The v3 architecture prioritizes:
- **Modularity**: Pick only what you need
- **Maintainability**: Clear separation of concerns
- **Extensibility**: Hook-based plugin system
- **Performance**: Sub-100ms operation targets
- **Compatibility**: Works with Claude Code updates

Each component follows single-responsibility principle with graceful degradation when dependencies are unavailable.

## License

MIT - See LICENSE file for details

## Star History

<a href="https://www.star-history.com/#NomenAK/SuperClaude&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date" />
 </picture>
</a>

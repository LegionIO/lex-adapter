# lex-adapter

External agent adapter abstraction for LegionIO. Provides a standardized interface for invoking external AI agents via CLI, process, or HTTP.

## Adapters

| Adapter | Transport | Use Case |
|---|---|---|
| `GenericProcess` | stdin/stdout | Any CLI tool that accepts input and returns output |
| `GenericHTTP` | HTTP POST | REST API endpoints |
| `ClaudeCode` | CLI subprocess | Anthropic Claude Code sessions |
| `Codex` | CLI subprocess | OpenAI Codex CLI sessions |

## Usage

```ruby
require 'legion/extensions/adapter'

# Register a custom adapter
Legion::Extensions::Adapter::Registry.register(:my_adapter, MyAdapter)

# Invoke via runner
result = Legion::Extensions::Adapter::Runners::Adapter.invoke(
  adapter: :claude_code,
  prompt: "Explain this code",
  options: { model: "claude-sonnet-4-20250514" }
)
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT

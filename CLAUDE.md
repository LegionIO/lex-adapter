# lex-adapter

**Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

External agent adapter abstraction for LegionIO. Provides a standardized interface for invoking external AI agents via CLI subprocess, HTTP, or arbitrary process. Adapters are registered by name and invoked through a single runner interface.

## Gem Info

- **Gem name**: `lex-adapter`
- **Version**: `0.1.1`
- **Module**: `Legion::Extensions::Adapter`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/adapter/
  version.rb
  base.rb              # Adapter::Base — abstract base class: invoke(prompt:, options:) interface
  registry.rb          # Registry — register(name, klass), lookup(name), all_adapters
  adapters/
    claude_code.rb     # ClaudeCode — invokes claude CLI as subprocess
    codex.rb           # Codex — invokes codex CLI as subprocess
    generic_process.rb # GenericProcess — stdin/stdout subprocess for any CLI tool
    generic_http.rb    # GenericHTTP — HTTP POST to arbitrary REST endpoints
  runners/
    adapter.rb         # Runners::Adapter — invoke(adapter:, prompt:, options:)
spec/
  legion/extensions/adapter/
    base_spec.rb
    registry_spec.rb
    adapters/
      claude_code_spec.rb
      codex_spec.rb
      generic_process_spec.rb
      generic_http_spec.rb
    runners/
      adapter_spec.rb
```

## Key Concepts

### Adapter::Base

Abstract base class all adapters inherit from. Subclasses must implement `invoke(prompt:, **options)` and return `{ success:, output: }` or `{ success: false, error: }`.

### Registry

`Registry.register(name, klass)` registers an adapter under a symbol name. `Registry.lookup(name)` returns the class or raises `ArgumentError`. Built-in adapters are auto-registered at require time.

| Adapter Name | Class | Transport |
|---|---|---|
| `:claude_code` | `Adapters::ClaudeCode` | CLI subprocess (`claude` binary) |
| `:codex` | `Adapters::Codex` | CLI subprocess (`codex` binary) |
| `:generic_process` | `Adapters::GenericProcess` | Configurable stdin/stdout process |
| `:generic_http` | `Adapters::GenericHTTP` | HTTP POST with JSON payload |

### Runner

`Runners::Adapter.invoke(adapter:, prompt:, options: {})` looks up the adapter by name, instantiates it with `options`, calls `invoke(prompt:)`, and returns the result hash.

## Development Notes

- `data_required?` returns `false` — no DB dependency
- `remote_invocable?` returns `false`
- `ClaudeCode` and `Codex` spawn subprocesses via `Open3.capture3` — they require the respective CLI binaries to be installed
- `GenericHTTP` uses `Net::HTTP` only, no Faraday dependency
- All adapters rescue `StandardError` and return `{ success: false, error: message }`

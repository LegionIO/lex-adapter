# Changelog

## [0.1.0] - 2026-03-20

### Added
- Base adapter interface with `invoke`, `available?`, and `validate_options`
- Registry for adapter registration and lookup
- GenericProcess adapter for CLI tool invocation via stdin/stdout
- GenericHTTP adapter for REST API endpoint invocation
- ClaudeCode adapter for Anthropic Claude Code sessions
- Codex adapter for OpenAI Codex CLI sessions
- Runner module for framework-integrated invocation
- 25 specs with 90.2% line coverage

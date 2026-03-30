# Changelog

## [0.1.2] - 2026-03-30

### Changed
- update to rubocop-legion 0.1.7, resolve all offenses

## [0.1.1] - 2026-03-22

### Changed
- Add 7 runtime sub-gem dependencies to gemspec (legion-cache, legion-crypt, legion-data, legion-json, legion-logging, legion-settings, legion-transport)
- Update spec_helper to use real sub-gem helpers and Helpers::Lex stub instead of inline Legion::Logging mock
- Exclude gemspec from Metrics/BlockLength rubocop cop

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

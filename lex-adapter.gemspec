# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'legion/extensions/adapter/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-adapter'
  spec.version       = Legion::Extensions::Adapter::VERSION
  spec.authors       = ['Matthew Iverson']
  spec.email         = ['matt@legionio.dev']
  spec.summary       = 'External agent adapter abstraction for LegionIO'
  spec.description   = 'Standardized interface for invoking external AI agents via CLI, process, or HTTP'
  spec.homepage      = 'https://github.com/LegionIO/lex-adapter'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.files         = Dir['lib/**/*', 'CHANGELOG.md', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.metadata['rubygems_mfa_required'] = 'true'
end

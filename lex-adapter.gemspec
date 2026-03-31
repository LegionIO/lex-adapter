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

  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = 'https://github.com/LegionIO/lex-adapter'
  spec.metadata['documentation_uri']     = 'https://github.com/LegionIO/lex-adapter'
  spec.metadata['changelog_uri']         = 'https://github.com/LegionIO/lex-adapter'
  spec.metadata['bug_tracker_uri']       = 'https://github.com/LegionIO/lex-adapter/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{lib,spec}/**/*') + %w[lex-adapter.gemspec Gemfile]
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'legion-cache',     '>= 1.3.11'
  spec.add_dependency 'legion-crypt',     '>= 1.4.9'
  spec.add_dependency 'legion-data',      '>= 1.4.17'
  spec.add_dependency 'legion-json',      '>= 1.2.1'
  spec.add_dependency 'legion-logging',   '>= 1.3.2'
  spec.add_dependency 'legion-settings',  '>= 1.3.14'
  spec.add_dependency 'legion-transport', '>= 1.3.9'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
end

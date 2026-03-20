# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

module Legion
  module Logging
    def self.debug(_msg = nil); end
    def self.info(_msg = nil); end
    def self.warn(_msg = nil); end
    def self.error(_msg = nil); end
  end
end

require 'legion/extensions/adapter'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.disable_monkey_patching!
end

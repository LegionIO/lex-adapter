# frozen_string_literal: true

require 'legion/extensions/adapter/version'
require 'legion/extensions/adapter/base'
require 'legion/extensions/adapter/registry'
require 'legion/extensions/adapter/adapters/generic_process'
require 'legion/extensions/adapter/adapters/generic_http'
require 'legion/extensions/adapter/adapters/claude_code'
require 'legion/extensions/adapter/adapters/codex'
require 'legion/extensions/adapter/runners/adapter'

module Legion
  module Extensions
    module Adapter
      class << self
        def remote_invocable? = false
        def data_required? = false
      end
    end
  end
end

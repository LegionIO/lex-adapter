# frozen_string_literal: true

module Legion
  module Extensions
    module Adapter
      class Registry
        @adapters = {}

        class << self
          def register(name, klass)
            @adapters[name.to_s] = klass
          end

          def find(name)
            @adapters[name.to_s]
          end

          def all
            @adapters.dup
          end

          def names
            @adapters.keys
          end

          def reset!
            @adapters = {}
          end
        end
      end
    end
  end
end

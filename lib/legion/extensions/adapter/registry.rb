# frozen_string_literal: true

module Legion
  module Extensions
    module Adapter
      class Registry
        @adapters = {} # rubocop:disable ThreadSafety/MutableClassInstanceVariable

        class << self
          def register(name, klass)
            @adapters[name.to_s] = klass # rubocop:disable ThreadSafety/ClassInstanceVariable
          end

          def find(name)
            @adapters[name.to_s] # rubocop:disable ThreadSafety/ClassInstanceVariable
          end

          def all
            @adapters.dup # rubocop:disable ThreadSafety/ClassInstanceVariable
          end

          def names
            @adapters.keys # rubocop:disable ThreadSafety/ClassInstanceVariable
          end

          def reset!
            @adapters = {} # rubocop:disable ThreadSafety/ClassInstanceVariable
          end
        end
      end
    end
  end
end

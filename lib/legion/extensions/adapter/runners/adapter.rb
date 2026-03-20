# frozen_string_literal: true

module Legion
  module Extensions
    module Adapter
      module Runners
        module Adapter
          def invoke_adapter(adapter_name:, task:, timeout: 30, **)
            klass = Registry.find(adapter_name)
            return { success: false, reason: :adapter_not_found } unless klass

            adapter = klass.new(**)
            adapter.invoke(task: task, timeout: timeout)
          end

          def list_adapters(**)
            { success: true, adapters: Registry.names, count: Registry.names.size }
          end

          def adapter_status(adapter_name:, **)
            klass = Registry.find(adapter_name)
            return { success: false, reason: :adapter_not_found } unless klass

            adapter = klass.new(**)
            { success: true, adapter: adapter_name, status: adapter.status }
          end
        end
      end
    end
  end
end

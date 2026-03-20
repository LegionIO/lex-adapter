# frozen_string_literal: true

module Legion
  module Extensions
    module Adapter
      class Base
        def invoke(task:, timeout: 30, **)
          raise NotImplementedError, "#{self.class}#invoke not implemented"
        end

        def status
          raise NotImplementedError, "#{self.class}#status not implemented"
        end

        def cancel(handle:)
          raise NotImplementedError, "#{self.class}#cancel not implemented"
        end

        def output(handle:)
          raise NotImplementedError, "#{self.class}#output not implemented"
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'open3'
require 'securerandom'
require 'timeout'

module Legion
  module Extensions
    module Adapter
      module Adapters
        class GenericProcess < Base
          def initialize(command: nil, **opts)
            super()
            @command = command
            @opts = opts
            @handles = {}
          end

          def invoke(task:, timeout: 30, **)
            handle = SecureRandom.uuid
            start_time = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC)
            input = if task.is_a?(Hash)
                      begin
                        task.to_json
                      rescue StandardError
                        task.to_s
                      end
                    else
                      task.to_s
                    end

            stdout, stderr, status = Timeout.timeout(timeout) do
              Open3.capture3(@command, stdin_data: input)
            end

            duration = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC) - start_time
            @handles[handle] = { stdout: stdout, stderr: stderr, exit_code: status.exitstatus }

            { success: status.success?, output: stdout, duration: duration, handle: handle }
          rescue Timeout::Error
            { success: false, output: nil, duration: timeout.to_f, handle: handle, reason: :timeout }
          rescue StandardError => e
            { success: false, output: nil, duration: 0.0, handle: handle, reason: :error, message: e.message }
          end

          def status
            available = system("which #{@command}", out: File::NULL, err: File::NULL) || false
            { available: available, command: @command }
          end

          def cancel(handle:)
            return { success: false, reason: :not_found } unless @handles.key?(handle)

            { success: true }
          end

          def output(handle:)
            @handles[handle] || { stdout: nil, stderr: nil, exit_code: nil }
          end
        end
      end
    end
  end
end

Legion::Extensions::Adapter::Registry.register('generic_process',
                                               Legion::Extensions::Adapter::Adapters::GenericProcess)

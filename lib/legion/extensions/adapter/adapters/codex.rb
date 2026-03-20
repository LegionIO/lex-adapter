# frozen_string_literal: true

require 'open3'
require 'securerandom'
require 'timeout'

module Legion
  module Extensions
    module Adapter
      module Adapters
        class Codex < GenericProcess
          BINARY = 'codex'

          def initialize(**)
            super(command: BINARY, **)
          end

          def invoke(task:, timeout: 120, **)
            prompt = task.is_a?(Hash) ? (task[:prompt] || task[:input] || task.to_json) : task.to_s
            handle = SecureRandom.uuid
            start_time = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC)

            stdout, stderr, status = Timeout.timeout(timeout) do
              Open3.capture3(BINARY, '--quiet', prompt)
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
            available = system("which #{BINARY}", out: File::NULL, err: File::NULL) || false
            version = available ? `#{BINARY} --version 2>/dev/null`.strip : nil
            { available: available, version: version, binary: BINARY }
          end
        end
      end
    end
  end
end

Legion::Extensions::Adapter::Registry.register('codex',
                                               Legion::Extensions::Adapter::Adapters::Codex)

# frozen_string_literal: true

require 'net/http'
require 'securerandom'
require 'json'
require 'uri'

module Legion
  module Extensions
    module Adapter
      module Adapters
        class GenericHttp < Base
          def initialize(url: nil, headers: {}, **opts)
            super()
            @url = url
            @headers = { 'Content-Type' => 'application/json' }.merge(headers)
            @opts = opts
          end

          def invoke(task:, timeout: 30, **)
            handle = SecureRandom.uuid
            start_time = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC)

            uri = URI(@url)
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = uri.scheme == 'https'
            http.open_timeout = timeout
            http.read_timeout = timeout

            request = Net::HTTP::Post.new(uri.path.empty? ? '/' : uri.path, @headers)
            request.body = task.is_a?(String) ? task : task.to_json

            response = http.request(request)
            duration = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC) - start_time

            { success: response.is_a?(Net::HTTPSuccess), output: response.body,
              status: response.code.to_i, duration: duration, handle: handle }
          rescue StandardError => e
            duration = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC) - start_time
            { success: false, output: nil, duration: duration, handle: handle,
              reason: :error, message: e.message }
          end

          def status
            { available: !@url.nil?, url: @url }
          end

          def cancel(_handle:)
            { success: false, reason: :not_supported }
          end

          def output(_handle:)
            { stdout: nil, stderr: nil, exit_code: nil }
          end
        end
      end
    end
  end
end

Legion::Extensions::Adapter::Registry.register('generic_http',
                                               Legion::Extensions::Adapter::Adapters::GenericHttp)

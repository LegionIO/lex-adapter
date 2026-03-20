# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Adapter::Runners::Adapter do
  let(:runner_instance) { Class.new { include Legion::Extensions::Adapter::Runners::Adapter }.new }

  before do
    r = Legion::Extensions::Adapter::Registry
    r.register('generic_process', Legion::Extensions::Adapter::Adapters::GenericProcess)
    r.register('generic_http', Legion::Extensions::Adapter::Adapters::GenericHttp)
    r.register('claude_code', Legion::Extensions::Adapter::Adapters::ClaudeCode)
    r.register('codex', Legion::Extensions::Adapter::Adapters::Codex)
  end

  describe '#invoke_adapter' do
    it 'invokes registered adapter by name' do
      result = runner_instance.invoke_adapter(adapter_name: 'generic_process', task: { input: 'test' },
                                              command: 'echo', timeout: 5)
      expect(result[:success]).to be true
    end

    it 'returns failure for unknown adapter' do
      result = runner_instance.invoke_adapter(adapter_name: 'nonexistent', task: {})
      expect(result[:success]).to be false
      expect(result[:reason]).to eq(:adapter_not_found)
    end
  end

  describe '#list_adapters' do
    it 'returns registered adapter names' do
      result = runner_instance.list_adapters
      expect(result[:success]).to be true
      expect(result[:adapters]).to include('generic_process')
      expect(result[:adapters]).to include('generic_http')
      expect(result[:adapters]).to include('claude_code')
      expect(result[:adapters]).to include('codex')
    end
  end

  describe '#adapter_status' do
    it 'returns status for a named adapter' do
      result = runner_instance.adapter_status(adapter_name: 'generic_http', url: 'http://example.com')
      expect(result[:success]).to be true
      expect(result[:status]).to have_key(:available)
    end
  end
end

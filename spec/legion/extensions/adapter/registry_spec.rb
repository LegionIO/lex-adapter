# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Adapter::Registry do
  before { described_class.reset! }

  let(:test_adapter_class) do
    Class.new(Legion::Extensions::Adapter::Base) do
      def invoke(task:, **) = { success: true }
      def status = { available: true, version: '1.0' }
      def cancel(handle:) = { success: true }
      def output(handle:) = { stdout: '', stderr: '', exit_code: 0 }
    end
  end

  describe '.register' do
    it 'stores adapter class by name' do
      described_class.register('test', test_adapter_class)
      expect(described_class.find('test')).to eq(test_adapter_class)
    end

    it 'accepts symbol names' do
      described_class.register(:test, test_adapter_class)
      expect(described_class.find('test')).to eq(test_adapter_class)
    end
  end

  describe '.find' do
    it 'returns nil for unregistered names' do
      expect(described_class.find('nonexistent')).to be_nil
    end
  end

  describe '.all' do
    it 'returns all registered adapters' do
      described_class.register('a', test_adapter_class)
      described_class.register('b', test_adapter_class)
      expect(described_class.all.keys).to contain_exactly('a', 'b')
    end
  end

  describe '.names' do
    it 'returns registered adapter names' do
      described_class.register('x', test_adapter_class)
      expect(described_class.names).to include('x')
    end
  end
end

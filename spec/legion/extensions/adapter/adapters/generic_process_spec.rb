# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Adapter::Adapters::GenericProcess do
  subject(:adapter) { described_class.new(command: 'echo') }

  describe '#invoke' do
    it 'executes the command and returns result' do
      result = adapter.invoke(task: { input: 'hello' }, timeout: 5)
      expect(result[:success]).to be true
      expect(result[:handle]).to be_a(String)
      expect(result[:duration]).to be_a(Float)
    end
  end

  describe '#status' do
    it 'returns available when command exists' do
      result = adapter.status
      expect(result[:available]).to be true
    end

    it 'returns unavailable when command missing' do
      bad = described_class.new(command: 'nonexistent_binary_xyz_99')
      result = bad.status
      expect(result[:available]).to be false
    end
  end

  describe '#cancel' do
    it 'returns success for unknown handle' do
      result = adapter.cancel(handle: 'nonexistent')
      expect(result[:success]).to be false
    end
  end

  describe 'self-registration' do
    it 'registers as generic_process' do
      expect(Legion::Extensions::Adapter::Registry.find('generic_process')).to eq(described_class)
    end
  end
end

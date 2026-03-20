# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Adapter::Adapters::GenericHttp do
  subject(:adapter) { described_class.new(url: 'http://localhost:19876/test') }

  describe '#invoke' do
    it 'returns failure when endpoint unreachable' do
      result = adapter.invoke(task: { input: 'test' }, timeout: 1)
      expect(result[:success]).to be false
    end
  end

  describe '#status' do
    it 'includes url in status' do
      result = adapter.status
      expect(result[:url]).to eq('http://localhost:19876/test')
    end
  end

  describe 'self-registration' do
    it 'registers as generic_http' do
      expect(Legion::Extensions::Adapter::Registry.find('generic_http')).to eq(described_class)
    end
  end
end

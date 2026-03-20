# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Adapter::Adapters::ClaudeCode do
  subject(:adapter) { described_class.new }

  describe '#status' do
    it 'returns a hash with available key' do
      result = adapter.status
      expect(result).to have_key(:available)
    end
  end

  describe 'self-registration' do
    it 'registers as claude_code' do
      expect(Legion::Extensions::Adapter::Registry.find('claude_code')).to eq(described_class)
    end
  end
end

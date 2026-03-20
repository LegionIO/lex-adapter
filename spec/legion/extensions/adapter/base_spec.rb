# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Adapter::Base do
  subject(:adapter) { described_class.new }

  describe '#invoke' do
    it 'raises NotImplementedError' do
      expect { adapter.invoke(task: {}) }.to raise_error(NotImplementedError)
    end
  end

  describe '#status' do
    it 'raises NotImplementedError' do
      expect { adapter.status }.to raise_error(NotImplementedError)
    end
  end

  describe '#cancel' do
    it 'raises NotImplementedError' do
      expect { adapter.cancel(handle: 'abc') }.to raise_error(NotImplementedError)
    end
  end

  describe '#output' do
    it 'raises NotImplementedError' do
      expect { adapter.output(handle: 'abc') }.to raise_error(NotImplementedError)
    end
  end
end

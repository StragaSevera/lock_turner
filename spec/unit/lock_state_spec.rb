# frozen_string_literal: true

require 'rspec'
require 'lock_state'

describe LockState do
  subject(:lock_state) { described_class.new(0, 1, 9) }

  context '#elements' do
    it 'has correct elements' do
      expect(lock_state.elements).to eq [0, 1, 9]
    end
  end

  context '#distance' do
    it 'calculates correct distance' do
      other = LockState.new(1, -2, 2)
      expect(lock_state.distance(other)).to eq 7
    end
  end

  context '#neighbours' do
    it 'calculates correct distance' do
      result = [
        LockState.new(9, 1, 9),
        LockState.new(1, 1, 9),
        LockState.new(0, 0, 9),
        LockState.new(0, 2, 9),
        LockState.new(0, 1, 8),
        LockState.new(0, 1, 0)
      ]
      expect(lock_state.neighbours).to match_array(result)
    end
  end
end

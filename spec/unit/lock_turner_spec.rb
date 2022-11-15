# frozen_string_literal: true

require 'rspec'
require 'lock_turner'

describe LockTurner do
  subject(:turner) { LockTurner.new(start, stop, forbidden_states) }

  context 'with simple route' do
    let(:start) { [0, 0, 0] }
    let(:stop) { [1, 1, 1] }
    let(:forbidden_states) do
      [
        [0, 0, 1],
        [1, 0, 0]
      ]
    end

    it 'finds correct way' do
      result = turner.solve

      expect(result).to eq [[0, 0, 0],
                            [0, 1, 0],
                            [0, 1, 1],
                            [1, 1, 1]]
    end
  end

  context 'with complex route' do
    let(:start) { [3, 4, 5] }
    let(:stop) { [3, 4, 8] }
    let(:forbidden_states) do
      [
        [3, 4, 6],
        [3, 5, 6],
        [3, 3, 6],
        [4, 4, 6],
        [2, 4, 7],
        [2, 3, 7],
        [3, 5, 7],
        [3, 5, 8],
        [2, 4, 8]
      ]
    end

    it 'finds correct way' do
      result = turner.solve

      expect(result).to eq [[3, 4, 5], 
                            [3, 3, 5], 
                            [3, 2, 5], 
                            [3, 2, 6], 
                            [3, 2, 7], 
                            [3, 3, 7], 
                            [3, 3, 8], 
                            [3, 4, 8]]
    end
  end
end

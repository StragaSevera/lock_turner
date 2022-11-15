# frozen_string_literal: true

class LockState
  attr_reader :elements

  def initialize(*elements)
    @elements = elements
  end

  def distance(other)
    elements.zip(other.elements).sum do |(a, b)|
      result = (a - b).abs
      result <= 5 ? result : 10 - result
    end
  end

  def neighbours
    (0..elements.size - 1).flat_map(&method(:neighbours_by_index))
  end

  def ==(other)
    other.is_a?(self.class) && elements == other.elements
  end

  def eql?(other)
    self == other
  end

  def hash
    elements.hash
  end

  private

  def neighbours_by_index(index)
    value = elements[index]
    [(value - 1) % 10, (value + 1) % 10].map do |element|
      neighbor = elements.dup
      neighbor[index] = element
      LockState.new(*neighbor)
    end
  end
end

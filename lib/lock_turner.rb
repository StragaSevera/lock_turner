# frozen_string_literal: true

require 'lock_state'
require 'fc'

class LockTurner
  def initialize(start, stop, forbidden_states)
    @start = LockState.new(start)
    @stop = LockState.new(stop)
    @forbidden_states = forbidden_states.map { |e| LockState.new(e) }
  end

  def solve
    previous_states = map_graph_states
    find_path(previous_states).map(&:elements)
  end

  private

  attr_reader :start, :stop, :forbidden_states

  def map_graph_states
    queue = FastContainers::PriorityQueue.new(:min)
    i = 0 # Using BFS for simplicity
    queue.push(start, i) 
    previous_states = { start => start }

    until queue.empty?
      current = queue.pop
      break if current == stop

      current.neighbours.each do |neighbour|
        unless previous_states.include?(neighbour) || forbidden_states.include?(neighbour)
          i += 1
          queue.push(neighbour, i) # Using BFS for simplicity
          previous_states[neighbour] = current
        end
      end
    end
    previous_states
  end

  def find_path(previous_states)
    current = stop
    path    = []
    loop do
      break if current.nil? || current == start

      current = previous_states[current]
      path << current
    end
    path = path.reverse << stop if path.any?
    path
  end
end

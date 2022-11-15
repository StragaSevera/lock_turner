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
    states_graph = map_states_graph
    find_path(states_graph).map(&:elements)
  end

  private

  attr_reader :start, :stop, :forbidden_states

  # Using A* algoritm for heuristic search
  def map_states_graph
    queue = FastContainers::PriorityQueue.new(:min)
    queue.push(start, start.distance_to(stop))
    states_graph = { start => start }
    costs = { start => 0 }

    until queue.empty?
      current = queue.pop
      break if current == stop
      current_cost = costs[current]

      current.neighbours.each do |neighbour|
        next if states_graph.include?(neighbour) || forbidden_states.include?(neighbour)

        priority = current_cost + current.distance_to(stop)
        queue.push(neighbour, priority)
        states_graph[neighbour] = current
        costs[neighbour] = current_cost + 1
      end
    end
    states_graph
  end

  def find_path(states_graph)
    current = stop
    path    = []
    loop do
      break if current.nil? || current == start

      current = states_graph[current]
      path << current
    end
    path = path.reverse << stop if path.any?
    path
  end
end

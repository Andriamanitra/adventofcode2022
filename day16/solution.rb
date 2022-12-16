require_relative '../lib/base.rb'

class Day16 < AdventOfCode
  def self.take_input(s)
    s.scan(/Valve (..) has flow rate=(\d+); tunnels? leads? to valves? (.*)/)
      .map{[_1, _2.to_i, _3.split(', ')]}
  end

  def self.bfs(map, a, b)
    q = [[a, 0]]
    visited = Set[]
    until q.empty?
      curr, steps = q.shift
      return steps if curr == b
      map[curr].each do |nextnode|
        q << [nextnode, steps + 1] if visited.add?(nextnode)
      end
    end
    raise "no path from #{a} to #{b}"
  end

  part(1) do |input|
    map = {}
    flows = {}
    input.each do |name, flowrate, tunnels|
      map[name] = tunnels
      flows[name] = flowrate
    end

    distance_between = {}

    map.keys.combination(2) do |a, b|
      dist = bfs(map, a, b)
      distance_between[a+b] = dist
      distance_between[b+a] = dist
    end

    useful_valves = flows.keys.select{|k| flows[k] > 0}

    best = 0
    q = [['AA', useful_valves.to_set, 30, 0]]

    until q.empty?
      me, closed_valves, t, score = q.shift
      best = score if score > best
      closed_valves.each do |valve|
        dist = distance_between[me+valve]
        if dist < t - 1
          remaining_time = t - dist - 1
          new_score = score + flows[valve] * remaining_time
          q << [valve, closed_valves.dup.delete(valve), remaining_time, new_score]
        end
      end
    end

    best
  end
end

Day16.run

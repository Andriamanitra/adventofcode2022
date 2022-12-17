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

  def self.distances(tunnels)
    distance_between = {}
    tunnels.keys.combination(2) do |from, to|
      dist = bfs(tunnels, from, to)
      distance_between[from+to] = dist
      distance_between[to+from] = dist
    end
    distance_between
  end

  part(1) do |input|
    map = {}
    flows = {}
    input.each do |valve, flowrate, tunnels|
      map[valve] = tunnels
      flows[valve] = flowrate
    end

    distance_between = distances(map)

    useful_valves = flows.keys.select{|k| flows[k] > 0}.to_set

    best = 0
    q = [['AA', useful_valves, 30, 0]]

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

  part(2) do |input|
    map = {}
    flows = {}
    input.each do |valve, flowrate, tunnels|
      map[valve] = tunnels
      flows[valve] = flowrate
    end

    distance_between = distances(map)

    # exclude useless valves from consideration
    useful_valves = flows.keys.select{|k| flows[k] > 0}.to_set

    # first calculate all paths i could take
    # keep track of best score for each set of opened valves
    scores = Hash.new(0)
    q = [['AA', useful_valves, 26, 0]]

    until q.empty?
      me, closed_valves, t, score = q.shift
      opened = useful_valves.difference(closed_valves)
      scores[opened] = score if score > scores[opened]
      closed_valves.each do |valve|
        dist = distance_between[me+valve]
        if dist < t - 1
          remaining_time = t - dist - 1
          new_score = score + flows[valve] * remaining_time
          q << [valve, closed_valves.dup.delete(valve), remaining_time, new_score]
        end
      end
    end

    # now find the pair of non-overlapping solutions that has the highest score

    # sorting the scores allows us to exit early
    sorted_scores = scores.sort_by { |_opened, score| -score }

    best = sorted_scores[0][1] # score if elephant did nothing at all!

    sorted_scores.each_with_index do |(opened, score), i|
      (i+1...sorted_scores.size).each do |j|
        opened_by_ele, ele_score = sorted_scores[j]
        total_score = score + ele_score

        break if total_score < best

        if opened.disjoint?(opened_by_ele)
          best = total_score
        end
      end
    end

    best
  end
end

Day16.run

require_relative '../lib/base.rb'

class Day16 < AdventOfCode
  def self.take_input(s)
    s.scan(/Valve (..) has flow rate=(\d+); tunnels? leads? to valves? (.*)/)
      .map{[_1, _2.to_i, _3.split(', ')]}
  end

  part('1 (slow)') do |input|
    map = {}
    flows = {}
    input.each do |name, flowrate, tunnels|
      map[name] = tunnels.map{[_1, 1]}
      flows[name] = flowrate
    end

    # remove nodes that don't have a flow
    flows.each do |k, flow|
      if k != 'AA' && flow == 0
        case map[k]
        in [[a, ad], [b, bd]]
          map[a].map!{|c, cd| c == k ? [b, ad+bd] : [c, cd]}
          map[b].map!{|c, cd| c == k ? [a, ad+bd] : [c, cd]}
          map.delete(k)
        end
      end
    end

    best = 0
    visited = Set[]
    q = [['AA', Set[], 30, 0, 0]]
    until q.empty?
      me, opens, t, score, income = q.shift
      if !opens.include?(me) && flows[me] > 0
        q << [me, opens.dup.add(me), t-1, score + income, income + flows[me]]
      end
      map[me].each do |dest, dist|
        if dist < t
          nextstate = [dest, opens, t-dist, score + income*dist, income]
          q << nextstate if visited.add?(nextstate)
        else
          total_score = score + income*t
          best = total_score if total_score > best
        end
      end
    end
    best
  end
end

Day16.run

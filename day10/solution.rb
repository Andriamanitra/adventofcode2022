require_relative '../lib/base.rb'

class Day10 < AdventOfCode
  def self.take_input(s)
    s.lines.map(&:split)
  end

  part(1) do |input|
    x = 1
    cycle = 0
    total = 0
    stops = [20, 60, 100, 140, 180, 220]
    input.each do |a|
      if a[0] == "addx"
        cycle += 2
        if cycle >= stops[0]
          total += stops.shift * x
          break if stops.empty?
        end
        x += a[1].to_i
      else
        cycle += 1
      end

      if cycle >= stops[0]
        total += stops.shift * x
        break if stops.empty?
      end
    end
    total
  end

  part(2) do |input|
    x = 1
    width = 40
    height = 6
    screen = Array.new(height){' ' * width}
    cycle = 0
    i = 0
    waiting = false
    height.times do |r|
      width.times do |w|
        screen[r][w] = (x-1..x+1) === w ? '█' : '.'
        cycle += 1
        
        if input[i][0] == "addx"
          if waiting
            waiting = false
            x += input[i][1].to_i
            i += 1
          else
            waiting = true
          end
        else
          i += 1
        end
      end
    end
    screen.join("\n")
  end
end

Day10.run

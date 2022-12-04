require_relative '../lib/base.rb'

class Day04 < AdventOfCode
  def self.take_input(s)
    s.split.map do |line|
      a, b, c, d = line.scan(/\d+/).map(&:to_i)
      [a..b, c..d]
    end
  end

  part(1) do |input|
    input.count do |a, b|
      b === a.begin && b === a.end || a === b.begin && a === b.end
    end
  end

  part(2) do |input|
    input.count do |a, b|
      a === b.begin || a === b.end || b === a.begin || b === a.end
    end
  end
end

Day04.run

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
      a.cover?(b) || b.cover?(a)
    end
  end

  part(2) do |input|
    input.count do |a, b|
      !(a.end < b.begin || b.end < a.begin)
    end
  end
end

Day04.run

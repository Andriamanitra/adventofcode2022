require_relative '../lib/base.rb'

class Day01 < AdventOfCode
  def self.take_input(s)
    s.split("\n\n").map { _1.split.map(&:to_i) }
  end

  part(1) do |input|
    input.map(&:sum).max
  end

  part(2) do |input|
    input.map(&:sum).max(3).sum
  end
end

Day01.run

require_relative '../lib/base.rb'

class Day05 < AdventOfCode
  def self.take_input(s)
    top, bottom = s.split("\n\n")
    stacklines = top.split("\n").reverse.map(&:chars).transpose.join.scan(/\w+/)
    stacks = stacklines.map{[_1[0].to_i, _1[1..].chars]}.to_h
    instructions = bottom.lines.map{_1.scan(/\d+/).map(&:to_i)}
    [stacks.freeze, instructions]
  end

  part(1) do |stacks, instructions|
    stacks = stacks.transform_values(&:dup)
    instructions.each do |n, from, to|
      stacks[to] += stacks[from].pop(n).reverse
    end
    stacks.map{_2.last}.join
  end

  part(2) do |stacks, instructions|
    stacks = stacks.transform_values(&:dup)
    instructions.each do |n, from, to|
      stacks[to] += stacks[from].pop(n)
    end
    stacks.map{_2.last}.join
  end
end

Day05.run

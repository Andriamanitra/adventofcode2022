require_relative '../lib/base.rb'

class Day13 < AdventOfCode
  def self.take_input(s)
    s.lines(chomp: true).reject(&:empty?).map { eval(_1) }
  end

  def self.compare(a, b)
    return 1 if b.nil?
    return a <=> b if a.is_a?(Integer) && b.is_a?(Integer)

    a = [a] if a.is_a?(Integer)
    b = [b] if b.is_a?(Integer)

    a.zip(b) do
      c = compare(_1, _2)
      return c if c != 0
    end

    a.size <=> b.size
  end

  part(1) do |packets|
    packets
      .each_slice(2)
      .zip(1..)
      .sum { |(a, b), i| compare(a, b) == -1 ? i : 0 }
  end

  part(2) do |input|
    divider_A = [[2]]
    divider_B = [[6]]
    packets = [*input, divider_A, divider_B]
    packets.sort!{ compare(_1, _2) }
    idx_A = 1 + packets.index(divider_A)
    idx_B = 1 + packets.index(divider_B)
    idx_A * idx_B
  end
end

Day13.run

require_relative '../lib/base.rb'

class Day03 < AdventOfCode
  def self.take_input(s)
    s.split
  end


  part(1) do |input|
    input.sum{|line|
      half = line.size / 2
      a, b = line[0,half], line[half,half]
      common = (a.chars & b.chars).first
      lettervalue(common)
    }
  end

  part(2) do |input|
    input.each_slice(3).sum{|a, b, c|
      common = (a.chars & b.chars & c.chars).first
      lettervalue(common)
    }
  end
end

def lettervalue(letter)
  v = letter.ord & 31
  v += 26 if letter.upper?
  v
end

Day03.run

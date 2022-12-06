require_relative '../lib/base.rb'

class Day06 < AdventOfCode
  def self.take_input(s)
    s.strip
  end

  part(1) do |input|
    4 + input.each_cons(4).find_index{ _1.uniq.size == 4 }
  end

  part(2) do |input|
    14 + input.each_cons(14).find_index{ _1.uniq.size == 14 }
  end
end

Day06.run

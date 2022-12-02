require_relative '../lib/base.rb'

class Day02 < AdventOfCode
  def self.take_input(s)
    s.lines.map(&:split)
  end

  ROCK = 0
  PAPER = 1
  SCISSORS = 2

  part(1) do |input|
    rps = {
      'A' => ROCK,
      'B' => PAPER,
      'C' => SCISSORS,
      'X' => ROCK,
      'Y' => PAPER,
      'Z' => SCISSORS,
    }
    input.sum do |a, b|
      them = rps[a]
      me = rps[b]
      score = me + 1
      score += 3 if them == me
      score += 6 if (them + 1) % 3 == me
      score
    end
  end

  part(2) do |input|
    rps = {
      'A' => ROCK,
      'B' => PAPER,
      'C' => SCISSORS,
    }
    input.sum{|a,b|
      them = rps[a]
      score = case b
      when 'X' # lose
        0 + (them - 1) % 3
      when 'Y' # draw
        3 + them
      when 'Z' # win
        6 + (them + 1) % 3
      end
      score + 1
    }
  end
end

Day02.run

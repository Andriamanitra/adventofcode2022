require_relative '../lib/base.rb'

class Day09 < AdventOfCode
  def self.take_input(s)
    s.lines.map{a, b = _1.split; [a, b.to_i]}
  end

  MOVES = {
    2i => 1i,
    -2i => -1i,
    2+0i => 1,
    -2+0i => -1,
    1+2i => 1+1i,
    2+1i => 1+1i,
    2+2i => 1+1i,
    1-2i => 1-1i,
    2-1i => 1-1i,
    2-2i => 1-1i,
    -1+2i => -1+1i,
    -2+1i => -1+1i,
    -2+2i => -1+1i,
    -1-2i => -1-1i,
    -2-1i => -1-1i,
    -2-2i => -1-1i,
  }
  MOVES.default = 0

  DIRECTIONS = { 'D' => -1i, 'U' => 1i, 'L' => -1, 'R' => 1 }

  part(1) do |input|
    head = 0 + 0i
    tail = 0 + 0i
    visited = []
    input.each do |dir, steps|
      steps.times do
        head += DIRECTIONS[dir]
        tail += MOVES[head - tail]
        visited.push(tail)
      end
    end
    visited.uniq.size
  end

  part(2) do |input|
    head = 0 + 0i
    tails = Array.new(9){0 + 0i}
    visited = []
    input.each do |dir, steps|
      steps.times do
        head += DIRECTIONS[dir]
        prev = head
        tails.each_index do |i|
          movement = MOVES[prev - tails[i]]
          break if movement == 0
          tails[i] += movement
          prev = tails[i]
        end
        visited.push(tails.last)
      end
    end
    visited.uniq.size
  end
end

Day09.run

require_relative '../lib/base.rb'

class Day15 < AdventOfCode
  def self.take_input(s)
    s.scan(/[-\d]+/).map(&:to_i).each_slice(4).to_a
  end

  def self.impossible_ranges(input, row_of_interest)
    ranges = input.filter_map do |sx, sy, bx, by|
      manhattan = (bx - sx).abs + (by - sy).abs
      d = manhattan - (sy - row_of_interest).abs
      cannot_a = sx - d
      cannot_a += 1 if [cannot_a, row_of_interest] == [bx, by]
      cannot_b = sx + d
      cannot_b -= 1 if [cannot_b, row_of_interest] == [bx, by]
      # discard empty ranges
      next if cannot_b <= cannot_a
      [cannot_a, cannot_b]
    end
  end

  part(1) do |input|
    # different row of interest in the example
    if input.first == [2, 18, -2, 15]
      row_of_interest = 10
    else
      row_of_interest = 2_000_000
    end

    ranges = impossible_ranges(input, row_of_interest).sort
    total = 0
    unless ranges.empty?
      curr = ranges.first[0] - 1

      ranges.map do |a, b|
        if b < curr
          total += 0
        elsif a > curr
          total += b - a + 1
          curr = b
        else
          total += b - curr
          curr = b
        end
      end
    end

    total
  end

  part(2) do |input|
    # different area of interest in the example
    if input.first == [2, 18, -2, 15]
      min_pos, max_pos = 0, 20
    else
      min_pos, max_pos = 0, 4_000_000
    end

    # because we know there exists only one solution in the entire area,
    # it must be true that it is located just outside the range of at
    # least two of the sensors (assuming it's not in the corner)
    # => only need to check intersections of the diagonals that limit
    #    the area around each sensor
    diags_se = []
    diags_ne = []
    sensors = []
    input.each do |sx, sy, bx, by|
      manhattan = (bx - sx).abs + (by - sy).abs
      range = manhattan
      diags_se << sx + sy + (range + 1) << sx + sy - (range + 1)
      diags_ne << sx - sy + (range + 1) << sx - sy - (range + 1)
      sensors << [sx, sy, range]
    end


    result = nil
    diags_se.product(diags_ne) do |se, ne|
      # diagonals don't intersect if their parity doesn't match
      next if se % 2 != ne % 2

      y = (se - ne) / 2
      x = se - y
      if (
          min_pos <= x && x <= max_pos &&
          min_pos <= y && y <= max_pos &&
          sensors.all? { |sx, sy, range| (sx - x).abs + (sy - y).abs > range }
      )
        result = 4_000_000 * x + y
        break
      end
    end

    # the given inputs probably never touch this edge case but in theory
    # the answer could be only on one diagonal if it's in the corner
    if result.nil?
      [[min_pos, max_pos], [max_pos, max_pos],
       [min_pos, min_pos], [max_pos, min_pos]].each do |x,y|
        if sensors.all? { |sx, sy, range| (sx - x).abs + (sy - y).abs > range }
          result = 4_000_000 * x + y
        end
      end
    end

    result
  end
end

Day15.run

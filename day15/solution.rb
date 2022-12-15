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
    # least one of the sensors
    diags = []
    sensors = []
    input.each do |sx, sy, bx, by|
      manhattan = (bx - sx).abs + (by - sy).abs
      range = manhattan
      ne = [sx, sy - range + 1, +1, +1, range + 1]
      se = [sx + range + 1, sy, -1, +1, range + 1]
      sw = [sx, sy + range + 1, -1, -1, range + 1]
      nw = [sx - range + 1, sy, +1, -1, range + 1]
      diags << ne << se << sw << nw
      sensors << [sx, sy, range]
    end
    result = nil
    catch (:found) do
      diags.each do |ax, ay, dx, dy, len|
        len.times do |i|
          x = ax + dx * i
          y = ay + dy * i
          if (
              min_pos <= x && x <= max_pos &&
              min_pos <= y && y <= max_pos &&
              sensors.all? { |sx, sy, range| (sx - x).abs + (sy - y).abs > range }
          )
            result = 4_000_000 * x + y
            throw :found
          end
        end
      end
    end
    result
  end
end

Day15.run

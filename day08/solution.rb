require_relative '../lib/base.rb'


class Day08 < AdventOfCode
  def self.take_input(s)
    Matrix[*s.split.map{_1.chars.map(&:to_i)}]
  end

  part(1) do |m|
    visibles = m.map{0}
    all = (0..)
    # edges are always visible
    visibles[0,   all] = 1
    visibles[-1,  all] = 1
    visibles[all, 0] = 1
    visibles[all, -1] = 1

    r_indices = 0..m.row_size - 1
    c_indices = 0..m.column_size - 1

    r_indices.each do |i|
      # visible from left
      high = 0
      c_indices.each do |j|
        if m[i, j] > high
          visibles[i, j] = 1
          high = m[i, j]
        end
      end

      # visible from right
      high = 0
      c_indices.reverse_each do |j|
        if m[i, j] > high
          visibles[i, j] = 1
          high = m[i, j]
        end
      end
    end

    c_indices.each do |j|
      # visible from top
      high = 0
      r_indices.each do |i|
        if m[i, j] > high
          visibles[i, j] = 1
          high = m[i, j]
        end
      end

      # visible from bottom
      high = 0
      r_indices.reverse_each do |i|
        if m[i, j] > high
          visibles[i, j] = 1
          high = m[i, j]
        end
      end
    end

    visibles.sum
  end

  part(2) do |m|
    best = 0
    maxi = m.row_size - 2
    maxj = m.column_size - 2
    (1..maxi).each do |vi|
      (1..maxj).each do |vj|
        v = m[vi, vj]
        up = 1 + (vi-1).downto(1).take_while{|i| v > m[i, vj]}.size
        down = 1 + (vi+1).upto(maxi).take_while{|i| v > m[i, vj]}.size
        left = 1 + (vj-1).downto(1).take_while{|j| v > m[vi, j]}.size
        right = 1 + (vj+1).upto(maxj).take_while{|j| v > m[vi, j]}.size
        scenic_score = up * down * left * right
        best = scenic_score if scenic_score > best
      end
    end
    best
  end
end

Day08.run

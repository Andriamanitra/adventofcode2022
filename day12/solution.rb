require_relative '../lib/base.rb'

class Day12 < AdventOfCode
  def self.take_input(s)
    grid = s.lines(chomp: true).map{ |line| line.each_char.map{_1.ord - ?a.ord} }
    height = grid.size
    width = grid[0].size
    start = s.index('S').divmod(width + 1)
    target = s.index('E').divmod(width + 1)
    grid[start[0]][start[1]] = 0
    grid[target[0]][target[1]] = 25
    [grid, [height, width], start, target]
  end

  part(1) do |grid, (h, w), start, target|
    # breadth-first search from start to target
    v = Set[]
    steps = 0
    q = []
    q << [*start, steps]
    loop {
      r, c, steps = q.shift
      break if [r, c] == target

      neighbors = []
      neighbors << [r-1, c] if r > 0
      neighbors << [r+1, c] if r + 1 < h
      neighbors << [r, c-1] if c > 0
      neighbors << [r, c+1] if c + 1 < w

      neighbors.each do |nb|
        if grid[r][c] + 1 >= grid[nb[0]][nb[1]]
          v.add?(nb) && q.push([*nb, steps+1])
        end
      end
    }
    steps
  end

  part(2) do |grid, (h, w), _, target|
    # breadth-first search from target to any 'a' (0)
    v = Set[]
    steps = 0
    q = []
    q << [*target, steps]
    loop {
      r, c, steps = q.shift
      break if grid[r][c] == 0

      neighbors = []
      neighbors << [r-1, c] if r > 0
      neighbors << [r+1, c] if r + 1 < h
      neighbors << [r, c-1] if c > 0
      neighbors << [r, c+1] if c + 1 < w

      neighbors.each do |nb|
        if grid[nb[0]][nb[1]] + 1 >= grid[r][c]
          v.add?(nb) && q.push([*nb, steps+1])
        end
      end
    }
    steps
  end
end

Day12.run

require_relative '../lib/base.rb'

class Day14 < AdventOfCode
  def self.take_input(s)
    s.lines(chomp: true).map do |line|
      line.split(' -> ').map { _1.split(',').map(&:to_i) }
    end
  end

  def self.build_obstacles(input)
    obstacles = Set[]
    input.each do |points|
      points.each_cons(2) do |(ac, ar), (bc, br)|
        ac, bc = [ac, bc].minmax
        ar, br = [ar, br].minmax
        if ac == bc
          (ar..br).each{|r| obstacles.add([r, ac]) }
        elsif ar == br
          (ac..bc).each{|c| obstacles.add([ar, c]) }
        end
      end
    end
    obstacles
  end

  part(1) do |input|
    obstacles = build_obstacles(input)
    lowest = obstacles.map{ |r, _| r }.max

    # depth-first search looking for first sand that flows to the abyss
    path = [[0, 500]]
    total = 0
    loop do
      r, c = path.last
      break if r > lowest # sand started flowing to abyss

      if !obstacles.include?(down = [r+1, c])
        path << down
      elsif !obstacles.include?(downL = [r+1, c-1])
        path << downL
      elsif !obstacles.include?(downR = [r+1, c+1])
        path << downR
      else # sand landed on something, backtrack
        obstacles.add(path.pop)
        total += 1
      end
    end
    total
  end

  part(2) do |input|
    obstacles = build_obstacles(input)
    lowest = obstacles.map{ |r, _| r }.max
    # breadth-first search from top to bottom, filling everything that
    # is required to support the topmost unit of sand
    q = [[0, 500]]
    total = 0
    until q.empty?
      r, c = q.shift
      total += 1
      next if r > lowest # sand hit the infinite floor
      if obstacles.add?(down  = [r+1, c])   then q << down end
      if obstacles.add?(downL = [r+1, c-1]) then q << downL end
      if obstacles.add?(downR = [r+1, c+1]) then q << downR end
    end
    total
  end
end

Day14.run

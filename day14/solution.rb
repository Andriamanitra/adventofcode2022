require_relative '../lib/base.rb'

class Column < Set
  def initialize
    # I guess using heaps would be little bit better
    # but keeping track of min/max is already a massive
    # improvement over an array or a set
    @min_element = nil
    @max_element = nil
    super
  end

  def min
    @min_element
  end

  def max
    @max_element
  end

  def add(val)
    @min_element = val if @min_element.nil? || @min_element > val
    @max_element = val if @max_element.nil? || @max_element < val
    super
  end
end


class Day14 < AdventOfCode
  def self.take_input(s)
    s.lines(chomp: true).map do |line|
      line.split(' -> ').map { _1.split(',').map(&:to_i) }
    end
  end

  def self.build_map(input)
    columns = Hash.new{ |h, k| h[k] = Column.new }
  
    input.each do |points|
      points.each_cons(2) do |(ac, ar), (bc, br)|
        ac, bc = [ac, bc].minmax
        ar, br = [ar, br].minmax
        if ac == bc
          (ar..br).each{|r| columns[ac].add(r)}
        elsif ar == br
          (ac..bc).each{|c| columns[c].add(ar)}
        end
      end
    end
    columns
  end

  def self.fall(columns, c, r)
    col = columns[c]

    # fell through to void
    return nil if col.empty? || r > col.max

    # try to fall straight down
    return fall(columns, c, r+1) unless col.include?(r+1)

    # try to slide left
    return fall(columns, c-1, r+1) unless columns[c-1].include?(r+1)

    # try to slide right
    return fall(columns, c+1, r+1) unless columns[c+1].include?(r+1)

    [c, r]
  end

  part(1) do |input|
    src = 500
    columns = build_map(input)

    total = 0
    while pos = fall(columns, src, columns[src].min - 1)
      sandc, sandr = pos
      total += 1
      columns[sandc].add(sandr)
    end
    total
  end

  part(2) do |input|
    src = 500
    columns = build_map(input)

    floor_level = 2 + columns.values.max_by(&:max).max

    # the floor is infinite but we only need a part of it that
    # is large enough to support a pile to get to the top
    (src - floor_level..src + floor_level).each do |c|
      columns[c].add(floor_level)
    end

    total = 0
    while pos = fall(columns, src, columns[src].min - 1)
      sandc, sandr = pos
      total += 1
      break if sandc == 500 && sandr == 0
      columns[sandc].add(sandr)
    end
    total
  end
end

Day14.run

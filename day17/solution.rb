require_relative '../lib/base.rb'

class Day17 < AdventOfCode
  WIDTH = 7
  ROCKS = [
    # line
    [[2,0], [3,0], [4,0], [5,0]],
    # plus
    [[3,0], [2,1], [3,1], [4,1], [3,2]],
    # L
    [[2,0], [3,0], [4,0], [4,1], [4,2]],
    # I
    [[2,0], [2,1], [2,2], [2,3]],
    # square
    [[2,0], [3,0], [2,1], [3,1]]
  ]

  def self.take_input(s)
    s.strip
  end

  def self.show(field, y_range)
    y_range.reverse_each do |y|
      if y < 1
        middle = '██' * WIDTH
      else
        middle = ''
        (0...WIDTH).each do |x|
          if val = field[[x, y]]
            color = %i(magenta green yellow blue red)[val % ROCKS.size]
            middle += '██'.send(color)
          else
            middle += '  '
          end
        end
      end
      puts "█#{middle}█"
    end
    puts
  end

  part(1) do |input|
    movement = input.each_char.map{|ch| ch == '<' ? -1 : 1}.cycle
    rocks = ROCKS.cycle
    maxh = 0
    landed = 0
    field = {}

    rock = rocks.next.map{|x, y| [x, y+4]}
    loop do
      # try to move according to input
      move = movement.next
      moved_rock = rock.map{|x, y| [x+move, y]}
      if moved_rock.all?{|x,y| 0 <= x && x < WIDTH && field[[x,y]].nil? }
        rock = moved_rock
      end

      # try to move down
      moved_rock = rock.map{|x, y| [x, y-1]}
      if moved_rock.all?{|x,y| y > 0 && field[[x,y]].nil? }
        rock = moved_rock
      else # land
        landed += 1
        rock.each { |pos| field[pos] = landed }
        highest = rock.map{_2}.max
        maxh = highest if highest > maxh
        break if landed == 2022
        rock = rocks.next.map{|x, y| [x, y+maxh+4]}
      end
    end
    # show(field, 0..10)
    maxh
  end
end

Day17.run

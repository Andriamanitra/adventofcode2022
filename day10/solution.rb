require_relative '../lib/base.rb'

class Cpu
  def initialize(x, &block)
    @x = x
    @cycle = 0
    @on_step_fn = block
  end

  def execute(instruction)
    case instruction.split
    in ["addx", num]
      step
      step
      @x += num.to_i
    in ["noop"]
      step
    end
  end

  def step
    @cycle += 1
    @on_step_fn.call(@x, @cycle)
  end
end


class Day10 < AdventOfCode
  def self.take_input(s)
    s.lines(chomp: true)
  end

  part(1) do |instructions|
    total = 0
    stops = [20, 60, 100, 140, 180, 220]
    instructions = instructions.each

    cpu = Cpu.new(1) do |x, cycle_number|
      if stops[0] == cycle_number
        total += cycle_number * x
        stops.shift
      end
    end

    cpu.execute(instructions.next) until stops.empty?
    total
  end

  part(2) do |instructions|
    width = 40
    screen = Array.new(6) { ' ' * width }

    cpu = Cpu.new(1) do |x, cycle_number|
      r, c = (cycle_number - 1).divmod(width)
      screen[r][c] = c.between?(x-1, x+1) ? '█' : '.'
    end

    instructions.each { |line| cpu.execute(line) }
    screen.join("\n")
  end
end

Day10.run

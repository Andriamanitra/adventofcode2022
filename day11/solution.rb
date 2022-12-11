require_relative '../lib/base.rb'

class Monkey
  def initialize(a, b, c, d, e, f)
    @num = a.split[1].to_i
    @items = b.split[2..].map(&:to_i)
    @op =
      case c.split('new = ')[1].split
      in ["old", "*", "old"] then ->(x){x * x}
      in ["old", "*", v]
        val = v.to_i
        ->(x){x * val}
      in ["old", "+", v]
        val = v.to_i
        ->(x){x + val}
      end
    @modulo = d[/\d+/].to_i
    @true_throw_to = e[/\d+/].to_i
    @false_throw_to = f[/\d+/].to_i
    @num_inspected = 0
  end

  def take_turn(worry_divisor, &block)
    until @items.empty?
      @num_inspected += 1
      worry = @op[@items.shift]
      if worry % @modulo == 0
        block.call(worry, @true_throw_to)
      else
        block.call(worry, @false_throw_to)
      end
    end
  end

  def receive_item(item)
    @items.push(item)
  end

  def modulo
    @modulo
  end

  def num_inspects
    @num_inspected
  end
end

class Day11 < AdventOfCode
  def self.take_input(s)
    s.split("\n\n").map{_1.lines}
  end

  part(1) do |input|
    monkeys = input.map{Monkey.new(*_1)}
    20.times do
      monkeys.each do |monkey|
        monkey.take_turn(3) do |worry, target|
          monkeys[target].receive_item(worry)
        end
      end
    end
    a, b = monkeys.map(&:num_inspects).max(2)
    a * b
  end

  part(2) do |input|
    monkeys = input.map{Monkey.new(*_1)}
    mod = monkeys.map(&:modulo).reduce{_1 * _2}
    10000.times do
      monkeys.each do |monkey|
        monkey.take_turn(1) do |worry, target|
          monkeys[target].receive_item(worry % mod)
        end
      end
    end
    a, b = monkeys.map(&:num_inspects).max(2)
    a * b
  end
end

Day11.run

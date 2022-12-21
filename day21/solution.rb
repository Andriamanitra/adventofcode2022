require_relative '../lib/base.rb'

class Day21 < AdventOfCode
  def self.take_input(s)
    monkeys = {}
    s.each_line(chomp: true).map do |line|
      k, v = line.split(': ')
      if v[' ']
        monkeys[k] = v.split
      else
        monkeys[k] = v.to_i
      end
    end
    monkeys
  end

  def self.get_value(monkeys, k)
    if k.is_a?(Integer)
      k
    elsif k.is_a?(String)
      get_value(monkeys, monkeys[k])
    elsif k.is_a?(Array)
      a, op, b = k
      av = get_value(monkeys, a)
      bv = get_value(monkeys, b)
      av.send(op, bv)
    end
  end

  part(1) do |monkeys|
    get_value(monkeys, 'root')
  end
end

Day21.run

require_relative 'colorize.rb'

require 'benchmark'
require 'prime'
require 'set'
require 'matrix'

class Integer
  def divisors
    factors = []
    (1..Integer.sqrt(self.abs)).each do |i|
      d, m = self.divmod(i)
      if m == 0
        factors << i
        factors << d if d != i
      end
    end
    factors.sort
  end
end

class String
  include Enumerable

  def lower?
    self.upcase != self && self.downcase == self
  end

  def upper?
    self.downcase != self && self.upcase == self
  end

  def each(&block)
    self.each_char do |ch|
      block.call(ch)
    end
  end
end

class AdventOfCode
  @@parts = Hash.new

  def self.part(id, &block)
    @@parts[id] = block
  end

  def self.default_input_file
    $0.sub('solution.rb', 'input.txt')
  end

  def self.example_file
    $0.sub('solution.rb', 'example.txt')
  end

  def self.solve_part(id, input_str)
    input = self.take_input(input_str)
    @@parts[id][input]
  end

  def self.run
    if File.exist?(example_file)
      example_input = take_input(File.read(example_file))
    else
      example_input = ''
    end

    ARGV.replace([default_input_file]) if ARGV.empty?
    raw_input = ARGF.read
    input = take_input(raw_input)

    @@parts.each do |part_name, solve|
      puts "#{self.name} part #{part_name}:".magenta
      time_taken = Benchmark.realtime {
        if example_input.empty?
          answer = solve[input]
          print "#{answer}".white
        else
          example_ans = "(example: #{solve[example_input]})"
          answer = solve[input]
          print "#{answer}  #{example_ans.bright_black}".white
        end
      }
      puts " – took #{(1000 * time_taken).round(3)} milliseconds".bright_black
    end
  end
end

require_relative '../lib/base.rb'

class Day07 < AdventOfCode
  def self.take_input(str)
    str.split('$ ')
       .reject(&:empty?)
       .map{ _1.split("\n").map(&:split) }
  end

  part(1) do |commands|
    dirs = Hash.new(0)
    cwd = []
    commands.each do |cmd, *args|
      case cmd
      in ['ls']
        total_contents_size = args.sum{ |sz, _fname| sz.to_i }
        (0...cwd.size).each do |i|
          dirs[cwd[0..i]] += total_contents_size
        end
      in ['cd','..'] then cwd.pop
      in ['cd', '/'] then cwd = []
      in ['cd', dir] then cwd.push(dir)
      else warn "unknown command #{cmd}"
      end
    end
    dirs.values.reject{_1 > 100000}.sum
  end

  part(2) do |commands|
    dirs = Hash.new(0)
    cwd = []
    commands.each do |cmd, *args|
      case cmd
      in ['ls']
        total_contents_size = args.sum{ |size, _fname| size.to_i }
        (0..cwd.size).each do |i|
          dirs[cwd[0,i]] += total_contents_size
        end
      in ['cd','..'] then cwd.pop
      in ['cd', '/'] then cwd = []
      in ['cd', dir] then cwd.push(dir)
      else warn "unknown command #{cmd}"
      end
    end
    total = 70000000
    required = 30000000
    free = total - dirs[[]]
    required -= free
    dirs.values.select{|size| size >= required}.min
  end
end

Day07.run

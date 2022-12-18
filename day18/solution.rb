require_relative '../lib/base.rb'

class Day18 < AdventOfCode
  def self.take_input(s)
    s.each_line.map do |line|
      line.split(',').map(&:to_i)
    end
  end

  part(1) do |input|
    area = 6 * input.size
    cubes = {}
    input.each do |x, y, z|
      cubes[[x,y,z]] = :occupied
      area -= 2 if cubes.include?([x-1,y,z])
      area -= 2 if cubes.include?([x+1,y,z])
      area -= 2 if cubes.include?([x,y-1,z])
      area -= 2 if cubes.include?([x,y+1,z])
      area -= 2 if cubes.include?([x,y,z-1])
      area -= 2 if cubes.include?([x,y,z+1])
    end
    area
  end

  part(2) do |input|
    cubes = {}
    xs, ys, zs = input.transpose
    xmin, xmax = xs.minmax
    ymin, ymax = ys.minmax
    zmin, zmax = zs.minmax

    # create a grid of initially empty cubes
    (xmin-1..xmax+1).each do |i|
      (ymin-1..ymax+1).each do |j|
        (zmin-1..zmax+1).each do |k|
          cubes[[i,j,k]] = :empty
        end
      end
    end

    input.each do |pos|
      cubes[pos] = :occupied
    end

    # 3D flood fill from the outside, deleting empty cubes
    q = [[xmin-1, ymin-1, zmin-1]]
    until q.empty?
      pos = q.pop
      unless cubes[pos] == :occupied
        cubes.delete(pos)
        x, y, z = pos
        q.push([x+1,y,z]) if cubes[[x+1,y,z]] == :empty
        q.push([x-1,y,z]) if cubes[[x-1,y,z]] == :empty
        q.push([x,y+1,z]) if cubes[[x,y+1,z]] == :empty
        q.push([x,y-1,z]) if cubes[[x,y-1,z]] == :empty
        q.push([x,y,z+1]) if cubes[[x,y,z+1]] == :empty
        q.push([x,y,z-1]) if cubes[[x,y,z-1]] == :empty
      end
    end

    cubes.each_key.sum do |x,y,z|
      area = 0
      area += 1 if cubes[[x+1,y,z]].nil?
      area += 1 if cubes[[x-1,y,z]].nil?
      area += 1 if cubes[[x,y+1,z]].nil?
      area += 1 if cubes[[x,y-1,z]].nil?
      area += 1 if cubes[[x,y,z+1]].nil?
      area += 1 if cubes[[x,y,z-1]].nil?
      area
    end
  end
end

Day18.run

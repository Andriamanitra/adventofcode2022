def part1
  p$<.sum{"BXCYAZAXBYCZCXAYBZ".index(_1[0]+_1[2])/2+1}
end

def part2
  p$<.sum{"BXCXAXAYBYCYCZAZBZ".index(_1[0]+_1[2])/2+1}
end

# Both parts
puts$<.map{|s|%w(BXCYAZAXBYCZCXAYBZ BXCXAXAYBYCYCZAZBZ).map{_1.index(s[0]+s[2])/2+1}}.transpose.map &:sum

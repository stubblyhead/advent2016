elves = (ARGV[0].to_i or 5)

def josephus(elves)
  return 2 * (elves - 2**(Math::log2(elves)).floor) + 1
end

puts josephus(elves)


# the sequence for part 2 starts at 1 at (3^x + 1), then increases by 1 until the circle has 2*3^x elves,
# then increases by 2 until the circle has 3^(x+1) elves.  the math works out as below:
def part2(elves)
  higher_power = Math::log(elves,3).ceil
  lower_power = higher_power - 1
  if elves == 3**higher_power
    return elves
  elsif elves >= 2*3**lower_power
    return elves - (3**lower_power - elves)
  else
    return elves - (3**lower_power)
  end
end

puts part2(elves)

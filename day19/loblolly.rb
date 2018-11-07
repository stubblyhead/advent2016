elves = (ARGV[0].to_i or 5)

def josephus(elves)
  return 2 * (elves - 2**(Math::log2(elves)).floor) + 1
end

puts josephus(elves)

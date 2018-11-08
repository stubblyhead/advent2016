ranges = ['5-8','0-2','4-7']

ruleshash = {}
ranges.each do |i|
  parts = i.split(?-)
  ruleshash[parts[0].to_i] = parts[1].to_i
end

blacklist = []
ruleshash.keys.sort.each do |i|
  blacklist += (i..ruleshash[i]).to_a
  blacklist.uniq!
end

puts blacklist

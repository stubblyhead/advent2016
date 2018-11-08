#ranges = ['5-8','0-2','4-7']
ranges = File.readlines('./input', :chomp=>true)


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

blacklist.each_index do |i|
  if blacklist[i] != i
    puts blacklist[i-1] + 1
    break
  end
end

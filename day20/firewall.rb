# require 'pry'
# binding.pry
#ranges = ['5-8','0-2','4-7']
ranges = File.readlines('./input', :chomp=>true)


ruleshash = {}
ranges.each do |i|
  parts = i.split(?-)
  ruleshash[parts[0].to_i] = parts[1].to_i
end

highest_seen = 0
ruleshash.keys.sort.each do |i|
  if i > highest_seen + 1
    puts highest_seen + 1
    break
  else
    highest_seen = ruleshash[i]
  end
end

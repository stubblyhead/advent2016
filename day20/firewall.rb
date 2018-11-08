# require 'pry'
# binding.pry
#ranges = ['5-8','0-2','4-7']
ranges = File.readlines('./input', :chomp=>true)


ruleshash = {}
ranges.each do |i|
  parts = i.split(?-)
  ruleshash[parts[0].to_i] = parts[1].to_i
end

allowed_addrs = 0
highest_seen  = 0
first_gap = 0

ruleshash.keys.sort.each do |i|
  if i > highest_seen + 1
    if first_gap == 0
      first_gap = highest_seen + 1
    end
    allowed_addrs += i - highest_seen - 1
  end
  highest_seen = ruleshash[i] unless highest_seen > ruleshash[i]
end

unless ruleshash.values.max == 4294967295
  allowed_addrs += 4294967295 - ruleshash.values.max
end

puts "lowest allowed address is #{first_gap}"
puts "#{allowed_addrs} total allowed addresses"

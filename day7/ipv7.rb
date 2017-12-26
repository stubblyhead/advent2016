require 'pry'
addresses = File.readlines('./testcase')
matches = []

addresses.each do |line|
  matches.push(line) if line.match(/(\w)(\w)\2\1/)
end

addresses.each do |line|
  addresses.delete(line) if line.match(/(\w)\1\1\1/)
end

addresses.each do |line|
  addresses.delete(line) if line.match(/\[(\w)(\w)\2\1\]/)
end

puts addresses.length

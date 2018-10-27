addresses = File.readlines('./input')
matches = []

addresses.each do |line|
  matches.push(line) if line.match(/(\w)(\w)\2\1/)
end

matches.each do |line|
  matches.delete(line) if line.match(/(\w)\1\1\1/)
end

matches.each do |line|
  matches.delete(line) if line.match(/\[.*(\w)(\w)\2\1.*\]/)
end

puts "#{matches.length} TLS addresses"

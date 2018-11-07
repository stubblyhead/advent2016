elves = Array.new(3018458)

elves.each_index { |i| elves[i] = [i+1, 1] }

until elves.length == 1
  elves.each_index do |i|
    elves[i][1] += elves[(i + 1) % elves.length][1]
    elves.delete_at((i + 1) % elves.length)
  end
end

puts elves[0][0]

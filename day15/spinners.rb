class Spinner
  attr_reader :positions, :current, :depth

  def initialize(positions, start, depth)
    @positions, @current, @depth = [positions, start, depth]
  end

  def tick
    @current = (@current + 1) % @positions
  end

  def delayed_position
    (@current + @depth) % @positions
  end

end


layers = []
layers[0] = Spinner.new(1,0,0)

input = File.readlines('./input', :chomp => true)
input.each do |line|
  parts = line.split(' positions; at time=0, it is at position ')
  match = parts[0].match(/\d+.*?(\d+)/)
  positions = match[1].to_i
  start = parts[1].to_i
  depth = layers.length
  layers.push(Spinner.new(positions, start, depth))
end
layers.push(Spinner.new(11,0,layers.length))
time = 0

positions = Array.new(layers.length)
desired = Array.new(layers.length) {0}

positions.each_index { |i| positions[i] = layers[i].delayed_position }
until positions[0..-2] == desired[0..-2]
  time += 1
  layers.each { |i| i.tick }
  positions.each_index { |i| positions[i] = layers[i].delayed_position }
end

puts time

until positions == desired
  time += 1
  layers.each { |i| i.tick }
  positions.each_index { |i| positions[i] = layers[i].delayed_position }
end

puts time

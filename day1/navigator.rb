class Walker
  attr_reader :x, :y, :directon, :locations

  def initialize
    @x = 0
    @y = 0
    @direction = :north
    @locations = [[0,0]]
  end

  def walk(instr)
    turn = instr[0]
    distance = instr[1..-1].to_i
    case @direction
    when :north
      turn == 'R' ? @direction = :east : @direction = :west
    when :east
      turn == 'R' ? @direction = :south : @direction = :north
    when :south
      turn == 'R' ? @direction = :west : @direction = :east
    when :west
      turn == 'R' ? @direction = :north : @direction = :south
    end

    case @direction
    when :north
      (@y+1..@y+distance).each { |i| @locations.push([@x, i]) }
      @y += distance
    when :east
      (@x+1..@x+distance).each { |i| @locations.push([i, @y]) }
      @x += distance
    when :south
      templocations = []
      (@y-distance..@y-1).each { |i| templocations.push([@x, i]) }
      @locations += templocations.reverse
      @y -= distance
    when :west
      templocations = []
      (@x-distance..@x-1).each { |i| templocations.push([i, @y]) }
      @locations += templocations.reverse
      @x -= distance
    end
  end
end

dirs = []
locations = []

File.open('./input') { |file| dirs = file.readline.chomp.split(', ') }


hq = Walker.new()

dirs.each do |i|
  hq.walk(i)
end

puts "#{hq.x.abs + hq.y.abs} steps from start to final position"

repeat_step = -1

hq.locations.reverse.each do |loc|
  if hq.locations.count(loc) > 1
    repeat_step = [repeat_step, hq.locations.reverse.index(loc)].max
  end
end
repeat_location = hq.locations.reverse[repeat_step]
puts "#{repeat_location[0].abs + repeat_location[1].abs} steps to first revisited location"

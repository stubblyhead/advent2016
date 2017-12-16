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

dirs = %w[R8 R4 R4 R8]

hq = Walker.new()

dirs.each do |i|
  hq.walk(i)
end

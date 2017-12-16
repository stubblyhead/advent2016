class Walker
  attr_reader :x, :y, :directon

  def initialize
    @x = 0
    @y = 0
    @direction = :north
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
      @y += distance
    when :east
      @x += distance
    when :south
      @y -= distance
    when :west
      @x -= distance
    end
  end
end

dirs = []

File.open('./input') { |file| dirs = file.readline.chomp.split(', ') }

hq = Walker.new()

dirs.each { |i| hq.walk(i) }

puts hq.x.abs + hq.y.abs

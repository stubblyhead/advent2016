require 'matrix'
require 'pry'

binding.pry

class Maze
  attr_reader :layout, :fav_num, :pos_x, :pos_y, :direction

  def initialize(fav_num)
    @fav_num = fav_num
    @layout = Array.new(50) { Array.new(50) }
    @layout.each_index do |y|
      @layout[y].each_index do |x|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |i| ones += value[i] }
        ones.even? ? @layout[y][x] = '.' : @layout[y][x] = '#'
      end
    end
    @pos_x, @pos_y = [1,1]
    @layout[1][1] = 'X'
    @direction = :south
  end

  def print_layout
    @layout.each { |i| puts i.join }
  end

  def next_direction
    local = [@layout[@pos_y-1][@pos_x-1,3],
             @layout[@pos_y][@pos_x-1,3],
             @layout[@pos_y+1][@pos_x-1,3]]
    case @direction
    when :north
      if local[2][2] == '#' and local[1][2] == '.'
        @direction = :east
      elsif local[0][1] == '#' and local[1][0] == '.'
        @direction = :west
      elsif local[0][1] == '#'
        @direction = :south
      end
    when :east
      if local[2][0] == '#' and local[2][1] == '.'
        @direction = :south
      elsif local[2][1] == '#' and local[0][1] == '.'
        @direction = :north
      elsif local[2][1] == '#'
        @direction = :west
      end
    when :south
      if local[0][0] == '#' and local[1][0] == '.'
        @direction = :west
      elsif local[2][1] == '#' and local[1][2] == '.'
        @direction = :east
      elsif local[2][1] == '#'
        @direction = :north
      end
    when :west
      if local[0][2] == '#' and local[0][1] == '.'
        @direction = :north
      elsif local[1][0] == '#' and local[2][1] == '.'
        @direction = :south
      elsif local[1][0] == '#'
        @direction = :east
      end
    end
  end

  def move
    next_diretion
    case @direction
    when :north
      @pos_y -= 1
    when :east
      @pos_x += 1
    when :south
      @pos_y += 1
    when :west
      @pos_x -= 1
    end
  end
end

unless ARGV[0]
  puts "please pass the favorite number as the first argument"
  exit
end

cubicles = Maze.new(ARGV[0].to_i)

10.times { cubicles.move }
cubicles.print_layout

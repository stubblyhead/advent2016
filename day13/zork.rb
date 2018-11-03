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
    local = []
    if @pos_y == @layout.length-1
      temp = Matrix[*layout]
      temp = Matrix.vstack(temp, Matrix.row_vector(Array.new(@layout[0].length)))
      @layout = temp.to_a
      y = @layout.length-1
      @layout[y].each_index do |x|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |j| ones += value[j] }
        ones.even? ? @layout[y][x] = '.' : @layout[y][x] = '#'
      end
    end

    if @pos_x == @layout[0].length-1
      temp = Matrix[*layout]
      temp = Matrix.hstack(temp, Matrix.col_vector(Array.new(@layout.length)))
      @layout = temp.to_a
      x = @layout[0].length-1
      @layout.each_index do |y|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |j| ones += value[j] }
        ones.even? ? @layout[y][x] = '.' : @layout[y][x] = '#'
      end
    end

    local = [@layout[@pos_y-1][@pos_x-1,3],
             @layout[@pos_y][@pos_x-1,3],
             @layout[@pos_y+1][@pos_x-1,3]]
    if @pos_y == 0
      @local[0].map! { |x| x = '#' }
    end
    if @pos_x == 0
      @local.each { |i| i[0] = '#' }
    end 
    floor = ['.', 'O']
    case @direction
    when :north
      if local[2][2] == '#' and floor.index(local[1][2])
        @direction = :east
      elsif local[0][1] == '#' and floor.index(local[1][0])
        @direction = :west
      elsif local[0][1] == '#'
        @direction = :south
      end
    when :east
      if local[2][0] == '#' and floor.index(local[2][1])
        @direction = :south
      elsif local[1][2] == '#' and floor.index(local[0][1])
        @direction = :north
      elsif local[1][2] == '#'
        @direction = :west
      end
    when :south
      if local[0][0] == '#' and floor.index(local[1][0])
        @direction = :west
      elsif local[2][1] == '#' and floor.index(local[1][2])
        @direction = :east
      elsif local[2][1] == '#'
        @direction = :north
      end
    when :west
      if local[0][2] == '#' and floor.index(local[0][1])
        @direction = :north
      elsif local[1][0] == '#' and floor.index(local[2][1])
        @direction = :south
      elsif local[1][0] == '#'
        @direction = :east
      end
    end
  end

  def get_north
    [@pos_y-1,@pos_x]
  end

  def get_south
    [@pos_y+1,@pos_x]
  end

  def get_east
    [@pos_y,@pos_x+1]
  end

  def get_west
    [@pos_y,@pos_x-1]
  end

  def move
    next_direction
    next_pos = self.send("get_"+@direction.to_s)
    if layout[next_pos[1]][next_pos[0]] == '.'
      layout[@pos_y][@pos_x] = 'O'
    else
      layout[@pos_y][@pos_x] = '.'
    end
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
    @layout[@pos_y][@pos_x] = 'X'
  end
end

unless ARGV[0]
  puts "please pass the favorite number as the first argument"
  exit
end

cubicles = Maze.new(ARGV[0].to_i)

100.times { |i| cubicles.move }
cubicles.print_layout

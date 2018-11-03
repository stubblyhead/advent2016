require 'matrix'
require 'pry'

binding.pry

class Maze
  attr_reader :layout, :fav_num, :pos_x, :pos_y, :direction, :max_x, :max_y

  def initialize(fav_num)
    @max_x, @max_y = [1,1]
    @fav_num = fav_num
    @layout = Array.new(40) { Array.new(40) }
    @layout.each_index do |y|
      @layout[y].each_index do |x|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |i| ones += value[i] }
        ones.even? ? @layout[y][x] = ' ' : @layout[y][x] = '#'
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
      puts "expanding down, pos_y = #{@pos_y}"
      temp = Matrix[*layout]
      temp = Matrix.vstack(temp, Matrix.row_vector(Array.new(@layout[0].length)))
      @layout = temp.to_a
      y = @layout.length-1
      @layout[y].each_index do |x|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |j| ones += value[j] }
        ones.even? ? @layout[y][x] = ' ' : @layout[y][x] = '#'
      end
    end

    if @pos_x == @layout[0].length-1
      puts "expanding right, pos_x = #{@pos_x}"
      temp = Matrix[*layout]
      temp = Matrix.hstack(temp, Matrix.column_vector(Array.new(@layout.length)))
      @layout = temp.to_a
      x = @layout[0].length-1
      @layout.each_index do |y|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |j| ones += value[j] }
        ones.even? ? @layout[y][x] = ' ' : @layout[y][x] = '#'
      end
    end

    local = [@layout[@pos_y-1][@pos_x-1,3],
             @layout[@pos_y][@pos_x-1,3],
             @layout[@pos_y+1][@pos_x-1,3]]
    if @pos_y == 0
      local[0].map! { |x| x = '#' }
    end
    if @pos_x == 0
      local.each { |i| i[0] = '#' }
    end
    floor = [' ', '•']
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
    if @layout[next_pos[0]][next_pos[1]] == ' '
      @layout[@pos_y][@pos_x] = '•'
    else
      @layout[@pos_y][@pos_x] = ' '
    end
    case @direction
    when :north
      @pos_y -= 1
    when :east
      @pos_x += 1
      @max_x = [@max_x, @pos_x].max
    when :south
      @pos_y += 1
      @max_y = [@max_y, @pos_y].max
    when :west
      @pos_x -= 1
    end
    @layout[@pos_y][@pos_x] = 'X'
  end

  def get_adjacent_nodes(node)
    x,y = *node
    if y == @layout.length-1
      #puts "expanding down, pos_y = #{y}"
      temp = Matrix[*layout]
      temp = Matrix.vstack(temp, Matrix.row_vector(Array.new(@layout[0].length)))
      @layout = temp.to_a
      @layout[y].each_index do |x|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |j| ones += value[j] }
        ones.even? ? @layout[y][x] = ' ' : @layout[y][x] = '#'
      end
    end

    if x == @layout[0].length-1
      #puts "expanding right, pos_x = #{x}"
      temp = Matrix[*layout]
      temp = Matrix.hstack(temp, Matrix.column_vector(Array.new(@layout.length)))
      @layout = temp.to_a
      @layout.each_index do |y|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |j| ones += value[j] }
        ones.even? ? @layout[y][x] = ' ' : @layout[y][x] = '#'
      end
    end

    if [x,y] == [0, 0]
      local = [%w(# # #),
               ['#', *@layout[y][x,2]],
               ['#', *@layout[y+1][x,2]]
              ]
    elsif x == 0
      local = [['#', *@layout[y-1][x,2]],
               ['#', *@layout[y][x,2]],
               ['#', *@layout[y+1][x,2]]
             ]
    elsif y == 0
      local = [%w(# # #),
               @layout[y][x-1,3],
               @layout[y+1][x-1,3]
             ]
    else
      local = [@layout[y-1][x-1,3],
               @layout[y][x-1,3],
               @layout[y+1][x-1,3]
             ]
    end

    adjacent = []
    if local[0][1] != '#'
      adjacent.push([[x,y-1], :north])
    end
    if local[1][0] != '#'
      adjacent.push([[x-1,y], :west])
    end
    if local[1][2] != '#'
      adjacent.push([[x+1,y], :east])
    end
    if local[2][1] != '#'
      adjacent.push([[x,y+1], :south])
    end
    return adjacent
  end
end

unless ARGV[0]
  puts "please pass the favorite number as the first argument"
  exit
end

cubicles = Maze.new(ARGV[0].to_i)

def search(cubicles)
  open_set = [] #places still to traverse
  closed_set = [] #places already traversed
  meta = {} #previous node, direction to get there

  root = [1,1] #origin
  meta[root] = [nil, nil]
  open_set.push(root)
  until open_set.empty?
    subtree_root = open_set.shift
    if subtree_root == [31, 39]
      return construct_path(subtree_root, meta)
    end
    cubicles.get_adjacent_nodes(subtree_root).each do |i|
      child, direction = *i
      next if closed_set.index(child)
      unless open_set.index(child)
        meta[child] = [subtree_root, direction]
        open_set.push(child)
      end
    end
    closed_set.push(subtree_root)
  end
end

def construct_path(state, meta)
  action_list = []
  path = []
  while meta[state] != [nil, nil]
    state, action = *meta[state]
    action_list.push(action)
    path.push(state)
  end
  return action_list.reverse, path.reverse
end

cubicles.print_layout
actions, path = search(cubicles)
actions.each_index { |i| puts "#{actions[i]} #{path[i]}" }
puts "#{actions.length} total moves"

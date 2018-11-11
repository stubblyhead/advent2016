require 'deep_clone'

class Puzzle
  attr_reader :layout, :empty, :goal

  def initialize(input)
    @layout = []
    input[2..-1].each do |i|
      parts = i.split
      used = parts[2].to_i
      nodepath = parts[0].split(?-)
      x = nodepath[1][1..-1].to_i
      y = nodepath[2][1..-1].to_i
      @layout.push([]) unless @layout[y]
      case
      when used > 100
        @layout[y][x] = '#'
      when used > 0
        @layout[y][x] = 'bre'
      when used == 0
        @layout[y][x] = '_'
        @empty = [y,x]
      end
    end
    @layout[0][-1] = 'G'
    @goal = [0,@layout[0].length-1]
  end

  # def initialize(layout, empty, goal)
  #   @layout, @empty, @goal = layout, empty, goal
  # end

  def set_goal(x)
    @layout[@goal[0]][@goal[1]] = '•'
    @layout[x[0]][x[1]] = 'G'
    @goal = x
  end

  def set_empty(x)
    @layout[@empty[0]][@empty[1]] = '•'
    @layout[x[0]][x[1]] = '_'
    @empty = x
  end

  def ==(other)
    if other.class == Puzzle and @layout.length == other.layout.length \
       and @layout[0].length == other.layout[0].length and @empty == other.empty \
       and @goal == other.goal
      return true
    else
      return false
    end
  end

  def print_layout
    @layout.each { |i| puts i.join }
  end

  def find_moves
    moves = [:up,:down,:left,:right]
    moves.delete(:up) if @empty[0] == 0 or @layout[@empty[0] - 1 ][@empty[1]] == '#'
    moves.delete(:down) if @empty[0] == @layout.length - 1 or @layout[@empty[0] + 1][@empty[1]] == '#'
    moves.delete(:left) if @empty[1] == 0
    moves.delete(:right) if @empty[1] == @layout[@empty[0]].length - 1 or @layout[@empty[0]][@empty[1] + 1] == '#'
    moves
  end

  def get_next(source)
    next_empty = @empty.clone
    current_empty = @empty.clone
    current_goal = @goal.clone
    case source
    when :up
      next_empty[0] -= 1
    when :down
      next_empty[0] += 1
    when :left
      next_empty[1] -= 1
    when :right
      next_empty[1] += 1
    end
    if next_empty == current_goal
      [next_empty, current_empty]
    else
      [next_empty, current_goal]
    end
  end



  def move(source)
    current = @empty
    case source
    when :up
      @empty[0] -= 1
    when :down
      @empty[0] += 1
    when :left
      @empty[1] -= 1
    when :right
      @empty[1] += 1
    end
    @layout[current[0]][current[1]] = @layout[empty[0]][empty[1]]
    @layout[empty[0]][empty[1]] = '_'
  end


end

def bfs(grid)
  open_set = []
  closed_set = []
  meta = {}
  #touched_goal = false
  root = [grid.empty,grid.goal]
  meta[root] = [nil,nil]
  open_set.push(root)

  until open_set.empty?
    subtree_root = open_set.shift
    if subtree_root[1] == [0,0]
      return construct_path(subtree_root, meta)
    else
      temp = DeepClone.clone(grid)
      temp.set_empty(subtree_root[0])
      temp.set_goal(subtree_root[1])
      moves = temp.find_moves
      moves.each do |i|
        new = temp.get_next(i)
        if new[1] != [0,34]
          touched_goal = true
        else
          touched_goal = false
        end
        if !closed_set.index(new) and !open_set.index(new) and (!touched_goal or (touched_goal and new[0][0] <= 1 and new[1][0] <= 1))
          meta[new] = [subtree_root, i]
          open_set.push(new)
        end
      end

      closed_set.push(subtree_root)
    end
  end
end

def construct_path(state, meta)
  actions = []
  while meta[state][0]
    state, action = meta[state]
    actions.push(action)
  end
  return actions.reverse
end

lines = File.readlines('./input', :chomp=>true)
mypuzzle = Puzzle.new(lines)
moves = bfs(mypuzzle)

puts "#{moves.length} moves to access data"

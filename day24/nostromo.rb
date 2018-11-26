require 'pry'
binding.pry

class HVAC
  attr_reader :grid, :shortest_paths, :locations

  def initialize(lines)
    @grid = Array.new
    lines.each { |i| @grid.push(i.split('')) }
    @locations = Array.new
    @shortest_paths = Hash.new
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        if @grid[row][col].match?(/\d/)
          @locations[@grid[row][col].to_i] = [row, col]
        end
      end
    end
  end

  def find_valid_moves(row, col)
    valid_moves = Array.new
    # grid has built-in walls so edge-checking isn't necessary
    valid_moves.push(:up) unless @grid[row-1][col] == ?#
    valid_moves.push(:down) unless @grid[row+1][col] == ?#
    valid_moves.push(:left) unless @grid[row][col-1] == ?#
    valid_moves.push(:right) unless @grid[row][col+1] == ?#
    valid_moves
  end

  def next_space(start, direction)
    row, col = *start
    case direction
    when :up
      return [row-1,col]
    when :down
      return [row+1, col]
    when :left
      return [row, col-1]
    when :right
      return [row, col+1]
    end
  end

  def find_shortest_paths
    @locations.each_index do |i|
      next if i == @locations.length - 1
      (i + 1..@locations.length - 1).each do |j|
        @shortest_paths[[i,j]] = bfs(i,j).length
      end
    end
  end

  private def bfs(source, dest)
    open_set = Array.new
    closed_set = Array.new
    meta = Hash.new
    meta[locations[source]] = [nil, nil]
    open_set.push(locations[source])

    until open_set.length == 0
      subtree_root = open_set.shift
      if subtree_root == locations[dest]
        return construct_path(subtree_root, meta)
      end
      valid_moves = find_valid_moves(*subtree_root)
      valid_moves.each do |i|
        move = next_space(subtree_root, i)
        next if closed_set.index(move)
        unless open_set.index(move)
          meta[move] = [subtree_root, i]
          open_set.push(move)
        end
      end
      closed_set.push(subtree_root)
    end
  end

  private def construct_path(loc, meta)
    action_list = Array.new

    until meta[loc][0] == nil
      loc, direction = meta[loc]
      action_list.push(direction)
    end
    return action_list.reverse
  end
end

lines = File.readlines('./testcase', :chomp => true)
mygrid = HVAC.new(lines)
mygrid.find_shortest_paths
true

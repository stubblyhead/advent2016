require 'pry'
binding.pry

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
        @layout[y][x] = '•'
      when used == 0
        @layout[y][x] = '_'
        @empty = [y,x]
      end
    end
    @layout[0][-1] = 'G'
    @goal = [-1,0]
  end

  def print_layout
    @layout.each { |i| puts i.join }
  end

  def find_moves
    moves = [:up,:down,:left,:right]
    moves.delete(:up) if @empty[0] == 0 or @layout[@empty[0] -1 ][@empty[1]] == '#'
    moves.delete(:down) if @empty[0] == @layout.length - 1 or @layout[@empty[0] + 1][@empty[1]] == '#'
    moves.delete(:left) if @empty[1] == 0
    moves.delete(:right) if @empty[1] == @layout[@empty[0]].length - 1 or @layout[@empty[0]][@empty[1] + 1] == '#'
    moves
  end

  def move(source)
    @layout[@empty[0]][@empty[1]] = '•'
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
    @layout[empty[0]][empty[1]] = '_'
  end


end

lines = File.readlines('./input', :chomp=>true)
mypuzzle = Puzzle.new(lines)

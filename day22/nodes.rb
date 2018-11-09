require 'pry'
binding.pry

class Node
  attr_reader :size, :used, :avail

  def initialize(size, used, avail)
    @size, @used, @avail = size, used, avail
  end

  def to_s
    "#{@size}, #{@used}, #{@avail}"
  end

end

grid = []

File.readlines('./input', :chomp=>true)[2..-1].each do |i|
  parts = i.split
  size = parts[1].to_i
  used = parts[2].to_i
  avail = parts[3].to_i
  nodepath = parts[0].split(?-)
  x = nodepath[1][1..-1].to_i
  y = nodepath[2][1..-1].to_i
  grid.push([]) unless grid[y]
  grid[y][x] = Node.new(size, used, avail)
end

viable = []
grid.each_index do |i|
  grid[i].each_index do |j|
    grid.each_index do |row|
      grid[row].each_index do |col|
        next if grid[i][j].used == 0 or (i == row and j == col)
        if grid[i][j].used <= grid[row][col].avail
          viable.push([[i,j],[row,col]].sort)
        end
      end
    end
  end
end

viable.uniq!
puts viable.length

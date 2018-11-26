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

  def find_shortest_paths
    @locations.each_index do |i|
      next if i == @locations.length - 1
      (i + 1..@locations.length - 1).each do |j|
        @shortest_paths[[i,j]] = "distance from #{i} to #{j}"
        bfs
      end
    end
  end

  private def bfs
    puts 'hi'
  end
end

lines = File.readlines('./testcase', :chomp => true)
mygrid = HVAC.new(lines)
mygrid.find_shortest_paths
true

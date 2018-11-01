require 'matrix'
require 'pry'
binding.pry
class Maze
  attr_reader :layout, :fav_num

  def initialize(fav_num)
    @fav_num = fav_num
    @layout = Array.new(10) { Array.new(10) }
    @layout.each_index do |y|
      @layout[y].each_index do |x|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |i| ones += value[i] }
        ones.even? ? @layout[y][x] = '.' : @layout[y][x] = '#'
      end
    end
  end

  def print_layout
    @layout.each { |i| puts i.join }
  end
end

unless ARGV[0]
  puts "please pass the favorite number as the first argument"
  exit
end

cubicles = Maze.new(ARGV[0].to_i)

cubicles.print_layout

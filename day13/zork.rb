require 'matrix'
require 'pry'

class Maze
  attr_reader :layout, :fav_num

  def initialize(fav_num)
    @fav_num = fav_num
    @layout = Matrix[Array.new(10) { Array.new(10) } ]
    @layout.each do |y|
      y.each do |x|
        value = x**2 + 3*x + 2*x*y + y + y**2 + @fav_num
        ones = 0
        Math.log(value, 2).ceil.downto(0) { |i| ones += value[i] }
        ones.even? ? @layout[y,x] = '.' : @layout[y,x] = '#'
      end
    end
  end

  def print_layout
    @layout.each { |i| puts i.join }
  end
end

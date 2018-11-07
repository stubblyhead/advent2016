require 'pry'
#binding.pry

class Traps
  attr_reader :layout

  def initialize(previous)
    @layout = ''
    trapmap = { ?^ => true, ?. => false }
    previous.chars.each_index do |i|
      if i == 0
        slice = [false, trapmap[previous[i]], trapmap[previous[i+1]] ]
      elsif i == previous.length - 1
        slice = [trapmap[previous[i-1]], trapmap[previous[i]], false]
      else
        slice = [trapmap[previous[i-1]], trapmap[previous[i]], trapmap[previous[i+1]] ]
      end
      case slice
      when [true, true, false]
        @layout += ?^
      when [false, true, true]
        @layout += ?^
      when [true, false, false]
        @layout += ?^
      when [false, false, true]
        @layout += ?^
      else
        @layout += ?.
      end
    end
  end

  def chars
    @layout.chars
  end

  def [](i)
    @layout[i]
  end

  def length
    @layout.length
  end

  def count(a)
    @layout.count(a)
  end

end

first = '^^.^..^.....^..^..^^...^^.^....^^^.^.^^....^.^^^...^^^^.^^^^.^..^^^^.^^.^.^.^.^.^^...^^..^^^..^.^^^^'
floormap = [first]
399.times { floormap.push(Traps.new(floormap[-1])) }

count = 0
floormap.each { |i| count += i.count(?.) }
puts count
puts floormap[0]
floormap[1..-1].each { |i| puts i.layout }

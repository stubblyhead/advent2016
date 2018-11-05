class Spinner
  attr_reader :positions, :start, :current

  def initialize(positions, start)
    @positions, @start = [positions, start]
    @current = @start
  end

  def tick
    @current = (@current + 1) % @positions
  end

end


layers = []
layers[0] = Spinner.new(1,0)
layers[1] = Spinner.new(5,4)
layers[2] = Spinner.new(2,1)
time = 0
print "time 0 "
layers.each { |i| print "#{i.current} " }
print "\n"

while true
  time += 1
  print "time #{time} "
  layers.each do |i|
    i.tick
    print "#{i.current} "
  end
  print "\n"
  sleep 1
end

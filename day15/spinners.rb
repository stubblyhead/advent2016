class Spinner
  attr_reader :positions, :start, :current

  def initialize(positions, start)
    @positions, @start = [positions, start]
    @current = @start
  end

  def tick
    @current = (@current + 1) % @start
  end

end

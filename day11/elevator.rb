require 'pry'
#binding.pry

class Board
  attr_reader :elevator, :generators, :chips

  def initialize(generators, chips, elevator)
    @elevator = elevator
    @chips = chips
    @generators = generators
  end

  def hash
    matched_pairs = [0,0,0,0]
    solo_chips = [0,0,0,0]
    solo_generators = [0,0,0,0]
    @chips.keys.each do |i|
      if @chips[i] == @generators[i]
        matched_pairs[@chips[i] - 1] += 1
      else
        solo_chips[@chips[i] - 1] += 1
        solo_generators[@generators[i] - 1] += 1
      end
    end

generators = { 'Hydrogen' => 2,
               'Lithium' => 3 }
chips = { 'Hydrogen' => 1,
          'Lithium' => 1 }
elevator = 1

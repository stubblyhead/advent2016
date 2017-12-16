class Keypad
  attr_reader :button, :sequence

  def initialize
    @button = 5
    @sequence = []
  end

  def next(directions)
    directions.each_char do |i|
      case @button
      when 1
        case i
        when 'R'
          @button = 2
        when 'D'
          @button = 4
        end
      when 2
        case i
        when 'R'
          @button = 3
        when 'L'
          @button = 1
        when 'D'
          @button = 5
        end
      when 3
        case i
        when 'L'
          @button = 2
        when 'D'
          @button = 6
        end
      when 4
        case i
        when 'R'
          @button = 5
        when 'U'
          @button = 1
        when 'D'
          @button = 7
        end
      when 5
        case i
        when 'R'
          @button = 6
        when 'L'
          @button = 4
        when 'D'
          @button = 8
        when 'U'
          @button = 2
        end
      when 6
        case i
        when 'U'
          @button = 3
        when 'L'
          @button = 5
        when 'D'
          @button = 9
        end
      when 7
        case i
        when 'U'
          @button = 4
        when 'R'
          @button = 8
        end
      when 8
        case i
        when 'R'
          @button = 9
        when 'L'
          @button = 7
        when 'U'
          @button = 5
        end
      when 9
        case i
        when 'U'
          @button = 6
        when 'L'
          @button = 8
        end
      end
    end
    @sequence.push(@button)
  end
end

dirs = %w[ULL RRDDD LURDL UUUUD]
keys = Keypad.new

dirs.each { |i| keys.next(i) }

puts keys.sequence.join

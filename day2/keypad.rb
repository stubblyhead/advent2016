class Keypad
  attr_reader :button, :sequence

  def initialize
    @button = '5'
    @sequence = ''
  end

  def next(directions)
    directions.each_char do |i|
      case @button
      when '1'
        case i
        when 'D'
          @button = '3'
        end
      when '2'
        case i
        when 'R'
          @button = '3'
        when 'D'
          @button = '6'
        end
      when '3'
        case i
        when 'L'
          @button = '2'
        when 'D'
          @button = '7'
        when 'U'
          @button = '1'
        when 'R'
          @button = '4'
        end
      when '4'
        case i
        when 'L'
          @button = '3'
        when 'D'
          @button = '8'
        end
      when '5'
        case i
        when 'R'
          @button = '6'
        end
      when '6'
        case i
        when 'U'
          @button = '2'
        when 'L'
          @button = '5'
        when 'D'
          @button = 'A'
        when 'R'
          @button = '7'
        end
      when '7'
        case i
        when 'U'
          @button = '3'
        when 'R'
          @button = '8'
        when 'L'
          @button = '6'
        when 'D'
          @button = 'B'
        end
      when '8'
        case i
        when 'R'
          @button = '9'
        when 'L'
          @button = '7'
        when 'U'
          @button = '4'
        when 'D'
          @button = 'C'
        end
      when '9'
        case i
        when 'L'
          @button = '8'
        end
      when 'A'
        case i
        when 'U'
          @button = '6'
        when 'R'
          @button = 'B'
        end
      when 'B'
        case i
        when 'R'
          @button = 'C'
        when 'L'
          @button = 'A'
        when 'U'
          @button = '7'
        when 'D'
          @button = 'D'
        end
      when 'C'
        case i
        when 'U'
          @button = '8'
        when 'L'
          @button = 'B'
        end
      when 'D'
        @button = 'B' if i == 'U'
      end
    end
    @sequence += @button
  end
end

dirs = []

File.open('./input') do |file|
  file.each_line { |line| dirs.push(line.chomp) }
end
keys = Keypad.new

dirs.each { |i| keys.next(i) }

puts keys.sequence

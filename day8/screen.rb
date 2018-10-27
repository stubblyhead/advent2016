class Screen
  def initialize(rows, cols)
    @pixels = Array.new(rows) { Array.new(cols) { '.' } }
  end

  def print
    @pixels.each { |i| puts i.join }
  end

  def rect(cols, rows)
    (0..rows-1).each do |i|
      (0..cols-1).each do |j|
        @pixels[i][j] = '#'
      end
    end
  end

  def rotate_row(row, shift)
    @pixels[row].rotate!(-shift)
  end

  def rotate_column(col, shift)
    temp_col = []
    @pixels.each { |i| temp_col.push(i[col]) }
    temp_col.rotate!(-shift)
    @pixels.each_index { |i| @pixels[i][col] = temp_col[i] }
  end

  def count_lights
    lights = 0
    @pixels.each { |i| lights += i.count('#') }
    lights
  end
end

instructions = File.readlines('./testcase', chomp: true)
lcd = Screen.new(3,7)
instructions.each do |line|
  parts = line.split
  case parts[0]
  when 'rect'
    args = parts[1].split('x')
    lcd.rect(args[0].to_i, args[1].to_i)
  when 'rotate'
    args = parts[1,4]
    lcd.send("rotate_#{args[0]}", args[1].match(/\d+/)[0].to_i, args[3].to_i)
  end
end

lcd.print
puts "#{lcd.count_lights} pixels lighted"

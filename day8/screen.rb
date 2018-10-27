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
end

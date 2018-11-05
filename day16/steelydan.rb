def expand(a)
  b = a.reverse
  b.chars.each_index do |i|
    b[i] == '0' ? b[i] = '1' : b[i] = '0'
  end
  return a + '0' + b
end

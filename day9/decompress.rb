require 'pry'
#binding.pry

compressed = 'X(8x2)(3x3)ABCY'
idx = 0
decompressed = ''

until compressed == ''

  next_part, paren, compressed = compressed.partition('(')
  decompressed += next_part
  marker, paren, compressed = compressed.partition(')')
  length, repeats = marker.split('x')
  repeats.to_i.times { decompressed += compressed[0,length.to_i] } if repeats  #repeats and lentgth are nil on last chunk, so skip this step and next
  compressed = compressed[length.to_i..-1] if length
end


puts "final string is #{decompressed}\nwhich is #{decompressed.length} characters long"

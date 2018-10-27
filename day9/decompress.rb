require 'pry'
binding.pry

compressed = 'ADVENT'
idx = 0
decompressed = ''

until compressed == ''

  next_part, paren, compressed = compressed.partition('(')
  decompressed += next_part
  marker, paren, compressed = compressed.partition(')')
  length, repeats = marker.split('x')
  repeats.times { decompressed += compressed[0,length] } if repeats  #repeats and lentgth are nil on last chunk, so skip this step and next
  compressed = compressed[length..-1] if length
end

puts decompressed.length

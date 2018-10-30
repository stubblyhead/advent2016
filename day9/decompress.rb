require 'pry'
#binding.pry

compressed = '(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN' #File.readlines('./input', chomp: true)[0]


def decompress(compressed)
  if compressed.index('(')
    next_part, paren, compressed = compressed.partition('(')
    marker, paren, compressed = compressed.partition(')')
    length, repeats = marker.split('x')
    compressed = compressed[0, length.to_i] * repeats.to_i + compressed[length.to_i..-1]
    decompressed = next_part + decompress(compressed)
  else
    decompressed = compressed
  end
  decompressed
end

decompressed = decompress(compressed)

puts "final v2 string is #{decompressed.length} characters long"

# while decompressed.index('(')  #for part two just keep going until there's no more parens
#   decompressed = decompress(decompressed)
# end
#
# puts "final v2 string is #{decompressed}\nwhich is #{decompressed.length} characters long"

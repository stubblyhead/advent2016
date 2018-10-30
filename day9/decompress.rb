require 'pry'
#binding.pry

compressed = File.readlines('./input', chomp: true)[0]


def decompress(compressed)
  decompressed = ''
  until compressed == ''

    next_part, paren, compressed = compressed.partition('(')
    decompressed += next_part
    marker, paren, compressed = compressed.partition(')')
    length, repeats = marker.split('x')
    repeats.to_i.times { decompressed += compressed[0,length.to_i] } if repeats  #repeats and lentgth are nil on last chunk, so skip this step and next
    compressed = compressed[length.to_i..-1] if length
  end
  decompressed
end

decompressed = decompress(compressed)

puts "final v1 string is #{decompressed}\nwhich is #{decompressed.length} characters long"

# while decompressed.index('(')  #for part two just keep going until there's no more parens
#   decompressed = decompress(decompressed)
# end
#
# puts "final v2 string is #{decompressed}\nwhich is #{decompressed.length} characters long"

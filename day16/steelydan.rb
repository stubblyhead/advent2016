require 'pry'
#binding.pry

def expand(a, length)
  b = a.reverse
  b.chars.each_index do |i|
    b[i] == '0' ? b[i] = '1' : b[i] = '0'
  end
  b = a + '0' + b
  puts b.length
  b.length >= length ? b[0,length] : expand(b, length)
end

def checksum(a, length)
  a_num = a.to_i(2)
  value = ''
  curr = length - 1
  while curr > 0
    value += (a_num[curr] == a_num[curr-1] ? "1" : "0")
    curr -= 2
  end
  value.length.odd? ? value : checksum(value, value.length)
end



length = 272

input = '00111101111101000'
dummy = expand(input, length)
puts checksum(dummy, length)

length2 = 35651584
dummy = input
dummy = expand(dummy, length2)
puts checksum(dummy, length2)

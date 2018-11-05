require 'pry'
binding.pry

def expand(a)
  b = a.reverse
  b.chars.each_index do |i|
    b[i] == '0' ? b[i] = '1' : b[i] = '0'
  end
  return a + '0' + b
end

def checksum(a)
  count = 0
  pairs = []
  while count < a.length
    pairs.push(a[count] + a[count + 1])
    count += 2
  end
  value = ''
  pairs.each do |i|
    i[0] == i[1] ? value += '1' : value += '0'
  end

  value.length.even? ? checksum(value) : value
end



length = 272

input = '00111101111101000'
dummy = input
until dummy.length >= length
  dummy = expand(dummy)
  puts dummy.length
end
dummy = dummy[0,length]

puts checksum(dummy)

require 'pry'

addresses = File.readlines('./testcase2', chomp: true)
matches = []

addresses.each do |line|
  matches.push(line) if line.match(/(\w)(\w)\2\1/)
end

matches.each do |line|
  matches.delete(line) if line.match(/(\w)\1\1\1/)
end

matches.each do |line|
  matches.delete(line) if line.match(/\[.*(\w)(\w)\2\1.*\]/)
end

#part 1 answer
puts "#{matches.length} TLS addresses"

matches = []

def find_palindrome(text)
  palindromes = []
  letters = text.chars
  letters.each_index do |i|
    break if i == letters.length - 2 #stop looking when there aren't two letters left to check
    if letters[i] == letters[i+2] and letters[i] != letters[i+1]
      palindromes.push(letters[i,3].join)
    end
  end
  palindromes
end

def invert_palindrome(text)
  text[1]+text[0]+text[1]
end

addresses.each do |line|
  #binding.pry
  templine = line
  supernet = []
  hypernet = []
  until line == ''
    supertext,sep,line = line.partition('[')
    supernet.push(supertext)
    hypertext,sep,line = line.partition(']')
    hypernet.push(hypertext)
  end
  supernet.delete('') #remove any empty strings that might be hanging on
  hypernet.delete('')

  supernet.each do |i|
    palindromes = find_palindrome(i)
    next if palindromes == []
    palindromes.each do |j|
      hypernet.each do |k|
        matches.push(templine) if k.index(invert_palindrome(j))
      end
    end
  end
end
matches.uniq!
puts "#{matches.length} SSL addresses"
p matches

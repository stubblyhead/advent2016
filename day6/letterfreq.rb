require 'pry'

words = File.readlines('./testcase')
most_frequent = ''

(0..words[0].length-1).each do |pos|
  histogram = Hash.new(0)
  words.each do |word|
    histogram[word[pos]] += 1
  end
  most_frequent += histogram.key(histogram.values.max)
end

puts most_frequent

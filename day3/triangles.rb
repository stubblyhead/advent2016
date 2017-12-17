def is_triangle?(lengths)
  return (lengths[2].to_i < (lengths[0].to_i + lengths[1].to_i) && lengths[1].to_i < (lengths[0].to_i + lengths[2].to_i) && lengths[0].to_i < (lengths[2].to_i + lengths[1].to_i) )
end

triangles = []
File.open './input' do |file|
  file.each_line { |line| triangles.push(line.chomp.split) }
end

triangles = triangles.transpose

valid = 0
triangles.each do |i|
  while i != []
    valid += 1 if is_triangle?(i.pop(3))
  end 
end
puts "#{valid} potential triangles"

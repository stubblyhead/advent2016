def part2(n, myturn)
  if n.length == 1
    n[0]
  else
    n.delete_at(myturn + (n.length/2).floor )
    part2(n, (myturn + 1) % n.length)
  end
end

(1..10).each do |i|
  circle = Array.new(i)
  circle.each_index { |i| circle[i] = i+1 }
  puts "#{i}\t#{part2(circle,0)}"
end    

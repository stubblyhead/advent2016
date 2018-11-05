require 'pry'
require 'digest'

binding.pry
key_candidates = []
keys = []

salt = (ARGV[0] or 'zpqevtbw')
(0..1063).each do |i|  #we'll need at least this many (though probably a lot more) so let's just get them calculated
  key_candidates.push(Digest::MD5.hexdigest(salt + i.to_s))
end

current_candidate = 0
until keys.length == 64
  match_data = key_candidates[current_candidate].match(/(\w)\1\1/)
  if match_data
    #puts "#{key_candidates[current_candidate]} at spot #{current_candidate} has 3 in a row"
    triple = match_data[1]
    ((current_candidate + 1)..(current_candidate + 1000)).each do |i|
      if i == key_candidates.length
        key_candidates.push(Digest::MD5.hexdigest(salt + i.to_s))
      end
      if key_candidates[i].match(/#{triple}{5}/)
    #    puts "#{key_candidates[i]} at spot #{i} has 5 in a row"
        keys.push(key_candidates[current_candidate])
        current_candidate += 1
        break
      end
    end
    #puts "no 5-match in #{current_candidate + 1} through #{current_candidate + 1000}"
    current_candidate += 1
  else
    current_candidate += 1
    next
  end
end

puts "took #{key_candidates.index(keys[-1])} tries to find 64 keys"

require 'pry'
require 'digest'

binding.pry
key_candidates = []
keys = []

salt = (ARGV[0] or 'zpqevtbw')
(1..1064).each do |i|  #we'll need at least this many (though probably a lot more) so let's just get them calculated
  key_candidates.push(Digest::MD5.hexdigest(salt + i.to_s))
end

current_candidate = 0
until keys.length == 64
  match_data = key_candidates[current_candidate].match(/(\w)\1\1/)
  if match_data
    triple = match_data[1]
    ((current_candidate + 1)..(current_candidate + 1001)).each do |i|
      if i == key_candidates.length
        key_candidates.push(Digest::MD5.hexdigest(salt + i.to_s))
      end
      if key_candidates[i].match(/#{triple}{5}/)
        keys.push(key_candidates[current_candidate])
        break
      end
    end
  else
    current_candidate += 1
    next
  end
end

puts "took #{key_candidates.length} tries to find 64 keys"

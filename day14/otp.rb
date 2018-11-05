require 'pry'
require 'digest'

#binding.pry
key_candidates = []
keys = []
indices = []

salt = (ARGV[0] or 'zpqevtbw')
(0..1063).each do |i|  #we'll need at least this many (though probably a lot more) so let's just get them calculated
  key_candidates.push(Digest::MD5.hexdigest(salt + i.to_s))
end

current_candidate = 0
until keys.length == 64  #keep trying until there are 64 valid keys
  match_data = key_candidates[current_candidate].match(/(\w)\1\1/)  #check current candidate for 3 in a row
  if match_data  #match found
    triple = match_data[1]  #character in 3 in a row
    ((current_candidate + 1)..(current_candidate + 1000)).each do |i|  #loop over next 1000 keys
      if i == key_candidates.length  #add on new hashes as necessary
        key_candidates.push(Digest::MD5.hexdigest(salt + i.to_s))
      end
      if key_candidates[i].match(/#{triple}{5,}/)  #check for 5 in a row of the same char
        keys.push(key_candidates[current_candidate])  #current candidate is a valid key, so add it to the list
        indices.push(current_candidate)
        break  #found a valid key so we can stop checking
      end
    end
    current_candidate += 1  #didn't find 5 in a row in the next 1000 keys, so start on the next in the list
  else
    current_candidate += 1  #this key didn't have 3 in a row, try the next
  end
end


puts "took #{key_candidates.index(keys[-1])} candidates to find 64 keys"

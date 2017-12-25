class Room
  attr_reader :name, :sector_id, :checksum
  def initialize(name, sector_id, checksum)
    @name = name
    @sector_id = sector_id
    @checksum = checksum
  end

  def calc_checksum
    lettercounts = Hash.new(0)
    longchecksum = ''
    nameletters = @name.gsub('-','')
    nameletters.each_char { |i| lettercounts[i] += 1 }
    lettercounts.values.uniq.sort.reverse.each do |count|
      #puts "gettings letters that occur #{count} times"
      thiscount = ''
      while lettercounts.key(count)
        #puts "adding #{lettercounts.key(count)}"
        thiscount += lettercounts.key(count)
        lettercounts.delete(thiscount[-1])
      end
      thiscount = thiscount.split('').sort.join
      longchecksum += thiscount
    end
    return longchecksum[0..4]
  end

  def is_real?
    return @checksum == calc_checksum
  end

  def decrypt_name
    decrypted = ''
    @name.each_byte do |byte|
      if byte == 45
        decrypted += ' '
      else
        decrypt_byte = ((byte - 97 + sector_id) % 26) + 97
        decrypted += decrypt_byte.chr
      end
    end
    return decrypted
  end
end

rooms = []
File.open('./input') do |file|
  file.each_line do |line|
    name_and_id, checksum = line.split('[')
    checksum.chomp!.chop!
    id = name_and_id[-3..-1].to_i
    name = name_and_id[0..-5]
    rooms.push(Room.new(name,id,checksum))
  end
end

sector_sum = 0

rooms.each do |i|
  if i.is_real?
    sector_sum += i.sector_id
  end

end

puts "sum of real room sector IDs is #{sector_sum}"

north_pole_candidates = []
rooms.each do |i|
  candidate = true
  decrypt_name = i.decrypt_name
  candidate = false if decrypt_name.index('rabbit')
  candidate = false if decrypt_name.index('bunny')
  candidate = false if decrypt_name.index('grass')
  candidate = false if decrypt_name.index('fuzzy')
  candidate = false if decrypt_name.index('dye')
  candidate = false if decrypt_name.index('jellybean')
  candidate = false if decrypt_name.index('egg')
  candidate = false if decrypt_name.index('basket')
  candidate = false if decrypt_name.index('chocolate')
  candidate = false if decrypt_name.index('flower')
  candidate = false if decrypt_name.index('candy')
  candidate = false if decrypt_name.index('scavenger')

  north_pole_candidates.push([decrypt_name, i.sector_id]) if candidate
end

north_pole_candidates.each { |i| puts i }

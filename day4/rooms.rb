require 'pry'

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
end

rooms = []
File.open('./testcase') do |file|
  file.each_line do |line|
    name_and_id, checksum = line.split('[')
    checksum.chomp!.chop!
    id = name_and_id[-3..-1].to_i
    name = name_and_id[0..-5]
    rooms.push(Room.new(name,id,checksum))
  end
end

sector_sum = 0

rooms.each { |i| sector_sum += i.sector_id if i.is_real? }

puts sector_sum

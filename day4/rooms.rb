class Room
  attr_reader :name, :sector_id, :checksum
  def initialize(name, sector_id, checksum)
    @name = name
    @sector_id = sector_id
    @checksum = checksum
  end
end

room = []
File.open('./testcase') do |file|
  file.each_line do |line|
    name_and_id, checksum = line.split('[')
    checksum.chomp!.chop!
    id = name_and_id[-3..-1].to_i
    name = name_and_id[0..-5]
    room.push(Room.new(name,id,checksum))
  end
end

p room

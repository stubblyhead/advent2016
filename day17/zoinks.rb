require 'digest'
require 'pry'

#binding.pry

class Room
  attr_reader :doors

  def initialize(up, down, left, right)
    @doors = {}
    @doors[:up] = up
    @doors[:down] = down
    @doors[:left] = left
    @doors[:right] = right
  end

  def lock(door)
    @doors[door] = :locked unless @doors[door] == :wall
  end

  def unlock(door)
    @doors[door] = :unlocked unless @doors[door] == :wall
  end

  def set_doors(code)
    open_char = /[b-f]/
    @doors.keys.each { |i| lock(i) }
    unlock(:up) if code[0].match(open_char)
    unlock(:down) if code[1].match(open_char)
    unlock(:left) if code[2].match(open_char)
    unlock(:right) if code[3].match(open_char)
  end

  def find_moves
    @doors.keys.map { |i| i if @doors[i] == :unlocked }.compact
  end



end

class Maze
  attr_reader :rooms, :passcode

  def initialize(passcode)
    @passcode = passcode
    @rooms = Array.new(4) { Array.new(4) }
    @rooms[0][0] = Room.new(:wall, :unlocked, :wall, :unlocked)
    @rooms[0][1] = Room.new(:wall, :unlocked, :unlocked, :unlocked)
    @rooms[0][2] = Room.new(:wall, :unlocked, :unlocked, :unlocked)
    @rooms[0][3] = Room.new(:wall, :unlocked, :unlocked, :wall)
    @rooms[1][0] = Room.new(:unlocked, :unlocked, :wall, :unlocked)
    @rooms[1][1] = Room.new(:unlocked, :unlocked, :unlocked, :unlocked)
    @rooms[1][2] = Room.new(:unlocked, :unlocked, :unlocked, :unlocked)
    @rooms[1][3] = Room.new(:unlocked, :unlocked, :unlocked, :wall)
    @rooms[2][0] = Room.new(:unlocked, :unlocked, :wall, :unlocked)
    @rooms[2][1] = Room.new(:unlocked, :unlocked, :unlocked, :unlocked)
    @rooms[2][2] = Room.new(:unlocked, :unlocked, :unlocked, :unlocked)
    @rooms[2][3] = Room.new(:unlocked, :unlocked, :unlocked, :wall)
    @rooms[3][0] = Room.new(:unlocked, :wall, :wall, :unlocked)
    @rooms[3][1] = Room.new(:unlocked, :wall, :unlocked, :unlocked)
    @rooms[3][2] = Room.new(:unlocked, :wall, :unlocked, :unlocked)
    @rooms[3][3] = Room.new(:unlocked, :wall, :unlocked, :wall)
  end

end

passcode = 'pvhmgsws'
mansion = Maze.new(passcode)
#roomhash = Digest::MD5.hexdigest(mansion.passcode)[0,4]
#Maze.rooms[0][0].set_doors(roomhash)

def bfs(mansion)
  open_set = []
  solution_paths = []
  root = [0,0,mansion.passcode]
  open_set.push(root)

  until open_set.empty?
    subtree_root = open_set.shift
    room = subtree_root[0,2]
    code = subtree_root[2]
    hash = Digest::MD5.hexdigest(code)[0,4]
    mansion.rooms[room[0]][room[1]].set_doors(hash)
    if room == [3,3]
      solution_paths.push(code)
      next
    end

    directions = mansion.rooms[room[0]][room[1]].find_moves
    directions.each do |i|
      nextcode = code + i.to_s.upcase[0]
      nextroom = room.clone
      if i == :up
        nextroom[0] -= 1
      elsif i == :down
        nextroom[0] += 1
      elsif i == :left
        nextroom[1] -= 1
      elsif i == :right
        nextroom[1] += 1
      end
      open_set.push(nextroom + [nextcode])
    end
  end
  return solution_paths
end

solution_paths = bfs(mansion)

puts "shortest path is #{solution_paths[0][mansion.passcode.length..-1]}"
puts "longest path is #{solution_paths[-1][mansion.passcode.length..-1].length} steps long"

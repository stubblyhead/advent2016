require 'pry'
binding.pry

class Scrambler

  def initialize(password)
    @password = password.chars
  end

  def swap_position(x,y)
    @password[x],@password[y] = @password[y],@password[x]
  end

  def swap_letter(x,y)
    swap_position(@password.index(x), @password.index(y))
  end

  def rotate_left(x)
    @password.rotate!(x)
  end

  def rotate_right(x)
    @password.rotate!(-x)
  end

  def rotate_x(x)
    position = @password.index(x)
    rotate_right(1 + position)
    rotate_right(1) if position >= 4
  end

  def reverse(x,y)
    @password = @password[0,x] + @password[x..y].reverse + @password[y+1..-1]
  end

  def move(x,y)
    char = @password[x]
    @password.delete_at(x)
    @password.insert(y, char)
  end

  def unrotate_x(x)
    position = @password.index(x)
    if position.odd?
      rotate_left((position/2.0) + 0.5)
    else
      position = 8 if position == 0
      rotate_left(position/2 + 5)
    end
  end

  def unrotate_left(x)
    rotate_right(x)
  end

  def unrotate_right(x)
    rotate_left(x)
  end

  def unmove(x,y)
    move(y,x)
  end

  def get_password
    @password.join
  end
end

input = File.readlines('./input', :chomp => true)
instructions = []
input.each do |i|
  parts = i.split
  if parts[0] == 'swap'
    if parts[1] == 'position'
      instructions.push(['swap_position', parts[2].to_i, parts[-1].to_i])
    else
      instructions.push(['swap_letter', parts[2], parts[-1]])
    end
  elsif parts[0] == 'reverse'
    instructions.push(['reverse', parts[2].to_i, parts[-1].to_i])
  elsif parts[0] == 'rotate'
    if parts[1] == 'based'
      instructions.push(['rotate_x', parts[-1]])
    else
      instructions.push(["rotate_#{parts[1]}", parts[2].to_i])
    end
  elsif parts[0] == 'move'
    instructions.push(['move', parts[2].to_i, parts[-1].to_i])
  end
end

password = Scrambler.new('abcdefgh')

print "#{password.get_password} scrambled is "
instructions.each do |i|
  password.send(*i)
end

puts password.get_password

unscramble = Scrambler.new('fbgdceah')
instructions = []
input.reverse.each do |i|
  parts = i.split
  if parts[0] == 'swap'
    if parts[1] == 'position'
      instructions.push(['swap_position', parts[2].to_i, parts[-1].to_i])
    else
      instructions.push(['swap_letter', parts[2], parts[-1]])
    end
  elsif parts[0] == 'reverse'
    instructions.push(['reverse', parts[2].to_i, parts[-1].to_i])
  elsif parts[0] == 'rotate'
    if parts[1] == 'based'
      instructions.push(['unrotate_x', parts[-1]])
    else
      instructions.push(["unrotate_#{parts[1]}", parts[2].to_i])
    end
  elsif parts[0] == 'move'
    instructions.push(['unmove', parts[2].to_i, parts[-1].to_i])
  end
end

print "#{unscramble.get_password} unscrambled is "
instructions.each_index do |i|
  unscramble.send(*instructions[i])
end
puts unscramble.get_password

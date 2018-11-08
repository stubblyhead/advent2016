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
    @password.remove_at(x)
    @password.insert(y, char)
  end
end

class Registers
  attr_reader :registers, :instructions

  def initialize(instructions)
    @instructions = instructions
    @registers = {}
    ('a'..'d').each { |i| @registers[i] = 0 }
    @pointer = 0
  end

  def cpy(x, y)
    x = x.to_i if x.match(/\d+/)
    x = @registers[x] unless x.class.to_s = 'Integer'
    @registers[y] = x
    @pointer += 1
  end

  def inc(x)
    @registers[x] += 1
    @pointer += 1
  end

  def dec(x)
    @registers[x] -= 1
    @pointer += 1
  end

  def jnz(x,y)
    offset = 1
    x = x.to_i if x.match(/\d+/)
    x = @registers[x] unless x.class.to_s == 'Integer'
    offset = y if x != 0
    @pointer += offset
  end

  def run
    until pointer >= @registers.length
      self.send(*(@registers[@pointer]))
    end
  end
end

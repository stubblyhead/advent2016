class Processor
  attr_reader :registers, :instructions

  def initialize(instructions, ignition=false)
    @instructions = instructions
    @registers = {}
    ('a'..'d').each { |i| @registers[i] = 0 }
    @pointer = 0
    @registers['c'] = 1 if ignition
  end

  def cpy(x, y)
    if y.class == String
      x = x.to_i if x.match(/\d+/)
      x = @registers[x] unless x.class == Integer
      @registers[y] = x
    end
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
    x = @registers[x] unless x.class == Integer
    offset = y.to_i if x != 0
    @pointer += offset
  end

  def tgl(x)
    x = @registers[x] unless x.class == Integer
    idx = @pointer + x
    if idx > 0 and idx < @instructions.length
      inst = @instructions[idx].split
      case inst[0]
      when 'cpy'
        @instructions[idx].sub!('cpy', 'jnz')
      when 'jnz'
        @instructions[idx].sub!('jnz', 'cpy')
      when 'inc'
        @instructions[idx].sub!('inc', 'dec')
      when 'dec'
        @instructions[idx].sub!('dec', 'inc')
      when 'tgl'
        @instructions[idx].sub!('tgl', 'inc')
      end
    end
    @pointer += 1
  end

  def run
    until @pointer >= @instructions.length
      self.send(*@instructions[@pointer].split)
    end
  end
end

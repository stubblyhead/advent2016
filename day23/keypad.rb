require 'pry'
require 'benchmark'

#binding.pry

class Processor
  attr_reader :registers, :instructions

  def initialize(instructions, eggs=0)
    @instructions = instructions
    @registers = {}
    ('a'..'d').each { |i| @registers[i] = 0 }
    @pointer = 0
    @registers['a'] = eggs
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

  def mul(x,y)
    y = y.to_i if y.match(/\d+/)
    y = @registers[y] unless y.class == Integer
    @registers[x] *= y
    @pointer += 1
  end

  def jnz(x,y)
    offset = 1
    x = x.to_i if x.match(/\d+/)
    y = y.to_i if y.match(/\d+/)
    x = @registers[x] unless x.class == Integer
    y = @registers[y] unless y.class == Integer
    offset = y if x != 0
    @pointer += offset
  end

  def tgl(x)
    x = x.to_i if x.match(/\d+/)
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
      #puts "#{@registers}  @instructions[#{@pointer}] => #{@instructions[@pointer]}"
    end
  end
end

def run(i)
  keypad = Processor.new(File.readlines('./input', :chomp=>true), i)
  keypad.run
  keypad.registers[?a]
end

puts "f(7) = #{run(7)}"
puts "f(12) = #{run(12)}"

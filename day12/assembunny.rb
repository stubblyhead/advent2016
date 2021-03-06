require 'pry'
#binding.pry

class Processor
  attr_reader :registers, :instructions

  def initialize(instructions, ignition)
    @instructions = instructions
    @registers = {}
    ('a'..'d').each { |i| @registers[i] = 0 }
    @pointer = 0
    @registers['c'] = 1 if ignition
  end

  def cpy(x, y)
    x = x.to_i if x.match(/\d+/)
    x = @registers[x] unless x.class.to_s == 'Integer'
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
    offset = y.to_i if x != 0
    @pointer += offset
  end

  def run
    until @pointer >= @instructions.length
      self.send(*@instructions[@pointer].split)
    end
  end
end

instructions = File.readlines('./input', :chomp => true)
proc = Processor.new(instructions, false)
proc.run
puts "register a is #{proc.registers['a']} for part 1"

proc = Processor.new(instructions, true)
proc.run
puts "register a is #{proc.registers['a']} for part 2"
